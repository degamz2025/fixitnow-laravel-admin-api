@extends('layouts.app')
@section('content')


<div id="content" class="app-content">
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">Shop</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Shop </h1>
    <!-- END page-header -->


    <div class="panel panel-inverse">
        <!-- BEGIN panel-heading -->
        <div class="panel-heading">
            <div class="panel-heading-btn">
                <a href="{{ route('admin-shop-create') }}" class="btn btn-xs btn-icon btn-success" title="Add new shop"><i class="fa fa-plus"></i></a>
                {{-- <a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i class="fa fa-times"></i></a> --}}
            </div>
        </div>
        <!-- END panel-heading -->
        <!-- BEGIN panel-body -->
        <div class="panel-body">
            <table id="data-table-default" width="100%" class="table table-striped table-bordered align-middle text-nowrap">
                <thead>
                    <tr>
                        <th width="1%"></th>
                        <th class="text-nowrap">Shop name</th>
                        <th class="text-nowrap">Owner</th>
                        <th class="text-nowrap">Created Date</th>
                        <th class="text-nowrap">Status</th>
                        <th class="text-nowrap" data-orderable="false" ></th>

                    </tr>
                </thead>
                <tbody>
                    @foreach ($shops as $shop)
                    <tr class="odd gradeX">
                        <td width="1%" class="fw-bold">{{$shop->shop_id}}</td>
                        <td>{{$shop->shop_name}}</td>
                        <td>{{$shop->name}}</td>
                        <td>{{ date('F j, Y g:i A', strtotime($shop->shop_created_at)) }}</td>
                        <td>{{$shop->shop_status}}</td>
                        <td class="text-center">
                            <a href="/admin-shop-view/{{$shop->shop_id}}" class="btn btn-primary btn-icon btn-circle btn-sm">
                                <i class="fa fa-file"></i>
                            </a>
                            <a href="{{ route('admin-shop-edit', $shop->shop_id) }}" class="btn btn-warning btn-icon btn-circle btn-sm">
                                <i class="fa fa-pencil"></i>
                            </a>
                            
                            <a href="javascript:;" class="btn btn-danger btn-icon btn-circle btn-sm">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    @endforeach

                </tbody>
            </table>
        </div>
        <!-- END panel-body -->

    </div>
    <!-- END row -->
</div>
<!-- END #content -->
<script>
    $("#shops").addClass('active')
</script>
@endsection

