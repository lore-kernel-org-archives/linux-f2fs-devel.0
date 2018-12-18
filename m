From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: use kvmalloc, if kmalloc is failed
Date: Tue, 18 Dec 2018 16:37:58 +0800
Message-ID: <a56ea91f-892d-a663-d4f2-6da8b851ec22@huawei.com>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214050127.45025-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/14 13:01, Jaegeuk Kim wrote:
> One report says memalloc failure during mount.
> 
>  (unwind_backtrace) from [<c010cd4c>] (show_stack+0x10/0x14)
>  (show_stack) from [<c049c6b8>] (dump_stack+0x8c/0xa0)
>  (dump_stack) from [<c024fcf0>] (warn_alloc+0xc4/0x160)
>  (warn_alloc) from [<c0250218>] (__alloc_pages_nodemask+0x3f4/0x10d0)
>  (__alloc_pages_nodemask) from [<c0270450>] (kmalloc_order_trace+0x2c/0x120)
>  (kmalloc_order_trace) from [<c03fa748>] (build_node_manager+0x35c/0x688)
>  (build_node_manager) from [<c03de494>] (f2fs_fill_super+0xf0c/0x16cc)
>  (f2fs_fill_super) from [<c02a5864>] (mount_bdev+0x15c/0x188)
>  (mount_bdev) from [<c03da624>] (f2fs_mount+0x18/0x20)
>  (f2fs_mount) from [<c02a68b8>] (mount_fs+0x158/0x19c)
>  (mount_fs) from [<c02c3c9c>] (vfs_kern_mount+0x78/0x134)
>  (vfs_kern_mount) from [<c02c76ac>] (do_mount+0x474/0xca4)
>  (do_mount) from [<c02c8264>] (SyS_mount+0x94/0xbc)
>  (SyS_mount) from [<c0108180>] (ret_fast_syscall+0x0/0x48)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
