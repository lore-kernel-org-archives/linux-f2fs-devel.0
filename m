From: Andrey Tsyvarev <tsyvarev@ispras.ru>
Subject: Re: f2fs: f2fs unmount hangs if f2fs_init_acl() fails
 during mkdir syscall
Date: Tue, 11 Feb 2014 12:29:57 +0400
Message-ID: <52F9DF85.7040402@ispras.ru>
References: <52F320FC.50803@ispras.ru> <1391666564.25542.78.camel@kjgkr>
	<52F37D67.208@ispras.ru> <1391734185.25542.80.camel@kjgkr>
	<1391749933.25542.83.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tsyvarev@ispras.ru>) id 1WD8jL-0002bv-43
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Feb 2014 08:30:11 +0000
Received: from smtp.ispras.ru ([83.149.199.79])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WD8jE-0001gl-Ed for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Feb 2014 08:30:11 +0000
In-Reply-To: <1391749933.25542.83.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi,

> It turns out that make_bad_inode prior to iput sets i_mode to a regular
> file, so that f2fs_evict_inode -> truncate_inode_pages ->
> f2fs_invalidate_data_page doesn't decrement dirty_dents.
>
It seems that remove_dirty_dir_inode() call should also be added to the 
error-path of
init_inode_metadata, because its functionality is also based on 
inode->i_mode field
which is changed by make_bad_inode().

Otherwise memory leak is reported when f2fs module is unloaded:

[  231.378192] BUG f2fs_dirty_dir_entry (Tainted: GF          O): 
Objects remaining in f2fs_dirty_dir_entry on kmem_cache_close()
[  231.378193] 
-----------------------------------------------------------------------------

[  231.378194] Disabling lock debugging due to kernel taint
[  231.378195] INFO: Slab 0xffffea0000437200 objects=102 used=1 
fp=0xffff880010dc8fc8 flags=0x3fffc000000080
[  231.378197] CPU: 0 PID: 2605 Comm: rmmod Tainted: GF   B      O 
3.14.0-rc1fs #4
[  231.378198] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  231.378199]  ffff88000e5e3200 ffff88000cc9bd40 ffffffff8166fd7e 
ffffea0000437200
[  231.378202]  ffff88000cc9be28 ffffffff811c3fdf ffff88003fc10066 
ffffffff0cc9bda0
[  231.378203]  ffffffff00000020 ffff88000cc9be38 ffff88000cc9bde0 
656a624f00000296
[  231.378205] Call Trace:
[  231.378210]  [<ffffffff8166fd7e>] dump_stack+0x45/0x56
[  231.378213]  [<ffffffff811c3fdf>] slab_err+0xaf/0xc0
[  231.378215]  [<ffffffff811c84a3>] ? kmem_cache_close+0x133/0x340
[  231.378216]  [<ffffffff811c6b55>] ? __kmalloc+0x1f5/0x250
[  231.378218]  [<ffffffff811c84c3>] kmem_cache_close+0x153/0x340
[  231.378221]  [<ffffffff81193417>] ? kmem_cache_destroy+0x27/0xf0
[  231.378223]  [<ffffffff811c86c4>] __kmem_cache_shutdown+0x14/0x80
[  231.378224]  [<ffffffff81193431>] kmem_cache_destroy+0x41/0xf0
[  231.378229]  [<ffffffffa01eab91>] destroy_checkpoint_caches+0x21/0x30 
[f2fs]
[  231.378232]  [<ffffffffa01facda>] exit_f2fs_fs+0x28/0x34e [f2fs]
[  231.378235]  [<ffffffff810ffe32>] SyS_delete_module+0x152/0x1f0
[  231.378237]  [<ffffffff8111d85c>] ? __audit_syscall_entry+0x9c/0xf0
[  231.378239]  [<ffffffff81680729>] system_call_fastpath+0x16/0x1b
[  231.378242] INFO: Object 0xffff880010dc8000 @offset=0
[  231.378245] kmem_cache_destroy f2fs_dirty_dir_entry: Slab cache still 
has objects
[  231.378247] CPU: 0 PID: 2605 Comm: rmmod Tainted: GF   B      O 
3.14.0-rc1fs #4
[  231.378247] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  231.378248]  ffff88000e5e3268 ffff88000cc9beb8 ffffffff8166fd7e 
ffff88000e5e3200
[  231.378250]  ffff88000cc9bed8 ffffffff811934cf 0000000000000000 
ffffffffa0204f60
[  231.378251]  ffff88000cc9bee8 ffffffffa01eab91 ffff88000cc9bef8 
ffffffffa01facda
[  231.378253] Call Trace:
[  231.378255]  [<ffffffff8166fd7e>] dump_stack+0x45/0x56
[  231.378256]  [<ffffffff811934cf>] kmem_cache_destroy+0xdf/0xf0
[  231.378259]  [<ffffffffa01eab91>] destroy_checkpoint_caches+0x21/0x30 
[f2fs]
[  231.378262]  [<ffffffffa01facda>] exit_f2fs_fs+0x28/0x34e [f2fs]
[  231.378263]  [<ffffffff810ffe32>] SyS_delete_module+0x152/0x1f0
[  231.378265]  [<ffffffff8111d85c>] ? __audit_syscall_entry+0x9c/0xf0
[  231.378266]  [<ffffffff81680729>] system_call_fastpath+0x16/0x1b


Stack of allocation (obtained with KEDR, which is also used for fault 
simulation):

[  231.414875] [leak_check] Address: 0xffff880010dc8000, size: 24; stack 
trace of the allocation:
[  231.414886] [leak_check] [<ffffffffa01e9d72>] 
set_dirty_dir_page+0x62/0xe0 [f2fs]
[  231.414893] [leak_check] [<ffffffffa01ec9be>] 
f2fs_set_data_page_dirty+0x4e/0x90 [f2fs]
[  231.414898] [leak_check] [<ffffffff8117b02a>] set_page_dirty+0x3a/0x60
[  231.414904] [leak_check] [<ffffffffa01dfeb2>] 
__f2fs_add_link+0x732/0x7d0 [f2fs]
[  231.414909] [leak_check] [<ffffffffa01e2f1b>] f2fs_mkdir+0xbb/0x150 
[f2fs]
[  231.414914] [leak_check] [<ffffffff811f2a37>] vfs_mkdir+0xb7/0x160
[  231.414918] [leak_check] [<ffffffff811f367f>] SyS_mkdir+0x5f/0xc0
[  231.414923] [leak_check] [<ffffffff81680729>] 
system_call_fastpath+0x16/0x1b
[  231.414931] [leak_check] [<ffffffffffffffff>] 0xffffffffffffffff


P.S. It was required to add 'slub_debug' kernel options for make SLUB 
output correct cache name,
otherwise cache "f2fs_dirty_dir_entry" was merged into "free_nid" one. 
It was surprise for me,
that's why patch investigation took so long time.

-- 
Best regards,
Andrey Tsyvarev
Linux Verification Center, ISPRAS
web:http://linuxtesting.org


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
