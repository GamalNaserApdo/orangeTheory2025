import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/models/booking_model.dart';
import 'package:otfksa2/ui/booking/bookings_viewmodel.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:provider/provider.dart';
// import 'package:your_app/models/booking_model.dart';
// import 'bookings_viewmodel.dart';
// import 'bookings_navigator.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    final viewModel = Provider.of<BookingsViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset('assets/images/orangetheory_logo.png'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.menu_1, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildHeader(context, viewModel),
            const SizedBox(height: 16),
            _buildStatsRow(viewModel),
            const SizedBox(height: 16),
            _buildSearchBar(viewModel),
            const SizedBox(height: 16),
            viewModel.isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                : _buildBookingsList(viewModel),
          ],
        ),
      ),
    );
  }

















  Widget _buildHeader(BuildContext context, BookingsViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bookings',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Manage class bookings',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => viewModel.onAddBookingPressed(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(Iconsax.calendar_add, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BookingsViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: _SmallStatCard(
            title: 'Today',
            value: viewModel.todayBookings,
            change: viewModel.todayChange,
            isPositive: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SmallStatCard(
            title: 'Week',
            value: viewModel.weekBookings,
            change: viewModel.weekChange,
            isPositive: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SmallStatCard(
            title: 'Cancel',
            value: viewModel.cancelRate,
            change: viewModel.cancelChange,
            isPositive: false,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BookingsViewModel viewModel) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: viewModel.searchController,
          decoration: const InputDecoration(
            icon: Icon(Iconsax.search_normal_1, color: Colors.grey),
            hintText: 'Search bookings...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingsList(BookingsViewModel viewModel) {
    if (viewModel.filteredBookings.isEmpty) {
      return const Expanded(child: Center(child: Text('No bookings found.')));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.filteredBookings.length,
        itemBuilder: (context, index) {
          final booking = viewModel.filteredBookings[index];
          return _BookingCard(
            booking: booking,
            onViewPressed: () =>
                viewModel.onViewBookingPressed(context, booking),
          );
        },
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String title, value, change;
  final bool isPositive;

  const _SmallStatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onViewPressed;

  const _BookingCard({required this.booking, required this.onViewPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.className,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _BookingStatusChip(status: booking.status),
              ],
            ),
            Text(
              booking.memberName,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(
                      title: 'Date',
                      value: booking.bookingDate.toLocal().toString().split(
                        ' ',
                      )[0],
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(title: 'Trainer', value: booking.trainerName),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(title: 'Time', value: booking.bookingTime),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: onViewPressed,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.bottomLeft,
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(
                            color: BookingsViewModel.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _BookingStatusChip extends StatelessWidget {
  final BookingStatus status;
  const _BookingStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    String text;
    Color bgColor;
    Color fgColor;

    switch (status) {
      case BookingStatus.Confirmed:
        text = 'Confirmed';
        bgColor = Colors.green.shade100;
        fgColor = Colors.green.shade800;
        break;
      case BookingStatus.Pending:
        text = 'Pending';
        bgColor = Colors.orange.shade100;
        fgColor = Colors.orange.shade800;
        break;
      case BookingStatus.Cancelled:
        text = 'Cancelled';
        bgColor = Colors.red.shade100;
        fgColor = Colors.red.shade800;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fgColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
