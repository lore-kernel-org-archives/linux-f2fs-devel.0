From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: walk around a panic caused by nrpages
 is not zero in clear_inode
Date: Wed, 7 Sep 2016 10:14:56 +0800
Message-ID: <28bd8111-d4ec-4340-3909-d0bcd3886c90@huawei.com>
References: <1473124652-31921-1-git-send-email-heyunlei@huawei.com>
	<20160907014705.GC10307@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bhSOk-0007XH-Pn
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 02:15:34 +0000
Received: from [119.145.14.52] (helo=szxga04-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bhSOi-0005tQ-I8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 02:15:34 +0000
In-Reply-To: <20160907014705.GC10307@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net


Hi, kim
On 2016/9/7 9:47, Jaegeuk Kim wrote:
> On Tue, Sep 06, 2016 at 09:17:32AM +0800, Yunlei He wrote:
>> I came across a panic twice:
>>
>> [<ffffffc000088e70>] dump_backtrace+0x0/0x124
>> [<ffffffc000088fb4>] show_stack+0x14/0x1c
>> [<ffffffc000ce1c38>] dump_stack+0x20/0x28
>> [<ffffffc000cdfbd4>] panic+0x13c/0x258
>> [<ffffffc0001b2244>] clear_inode+0x8c/0xd4
>> [<ffffffc00030575c>] f2fs_evict_inode+0x194/0x3e0
>> [<ffffffc0001b30b4>] evict+0xa0/0x1cc
>> [<ffffffc0001b399c>] iput+0xe4/0x180
>> [<ffffffc0003274fc>] recover_fsync_data+0x6ec/0xe5c
>> [<ffffffc00030d420>] f2fs_fill_super+0xa5c/0xb9c
>> [<ffffffc00019cd00>] mount_bdev+0x1ac/0x1d4
>> [<ffffffc00030b66c>] f2fs_mount+0x14/0x1c
>> [<ffffffc00019d5e4>] mount_fs+0x3c/0x1bc
>> [<ffffffc0001b7560>] vfs_kern_mount+0x4c/0xf0
>> [<ffffffc0001b9970>] do_mount+0x218/0x960
>> [<ffffffc0001ba148>] SyS_mount+0x90/0xd0
>
> Hmm, could you share the previous recovery messages?

Here is the previous recovery message:

<5>[    8.929199s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4e8, name = packages.xml
<5>[    8.930267s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4e8, name = packages.xml, dir = 8d, err = 0
<5>[    8.930572s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4e8, recovered = 85 blocks, err = 0
<5>[    8.930603s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4e9, name = packages.list.tmp
<5>[    8.930603s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4e9, name = packages.list.tmp, dir = 8d, err = 0
<5>[    8.930633s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4e9, recovered = 2 blocks, err = 0
<5>[    8.930664s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4ea, name = package-restrictions.xml
<5>[    8.931243s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4ea, name = package-restrictions.xml, dir = 1a3, err = 0
<5>[    8.931243s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4ea, recovered = 0 blocks, err = 0
<5>[    8.931274s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 23e, recovered = 0 blocks, err = 0
<5>[    8.931274s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 23e, name = entropy.dat
<5>[    8.931274s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 23e, recovered = 0 blocks, err = 0
<5>[    8.931304s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4eb, name = accounts.xml
<5>[    8.931884s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4eb, name = accounts.xml, dir = 248, err = 0
<5>[    8.931915s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4eb, recovered = 0 blocks, err = 0
<5>[    8.931915s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4ec, name = status.bin
<5>[    8.932098s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4ec, name = status.bin, dir = 248, err = 0
<5>[    8.932128s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4ec, recovered = 0 blocks, err = 0
<5>[    8.932128s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 24b, name = pending.xml
<5>[    8.932159s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 24b, recovered = 0 blocks, err = 0
<5>[    8.932159s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4ed, name = stats.bin
<5>[    8.932342s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4ed, name = stats.bin, dir = 248, err = 0
<5>[    8.932373s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4ed, recovered = 0 blocks, err = 0
<5>[    8.932373s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4ee, name = runtime-permissions.xml
<5>[    8.932556s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4ee, name = runtime-permissions.xml, dir = 1a3, err = 0
<5>[    8.932586s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4ee, recovered = 3 blocks, err = 0
<5>[    8.932617s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4ef, name = .temp.0TNPDd
<5>[    8.932922s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4ef, name = .temp.0TNPDd, dir = 7e, err = 0
<5>[    8.932952s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4ef, recovered = 0 blocks, err = 0
<5>[    8.932952s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4f0, name = packages.xml
<5>[    8.933013s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4f0, name = packages.xml, dir = 8d, err = 0
<5>[    8.933105s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4f0, recovered = 85 blocks, err = 0
<5>[    8.933135s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4f2, name = packages.list.tmp
<5>[    8.933166s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4f2, name = packages.list.tmp, dir = 8d, err = 0
<5>[    8.933197s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4f2, recovered = 2 blocks, err = 0
<5>[    8.933197s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4f4, name = package-restrictions.xml
<5>[    8.933227s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4f4, name = package-restrictions.xml, dir = 1a3, err = 0
<5>[    8.933258s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4f4, recovered = 0 blocks, err = 0
<5>[    8.933258s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4f8, name = runtime-permissions.xml
<5>[    8.933288s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4f8, name = runtime-permissions.xml, dir = 1a3, err = 0
<5>[    8.933319s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4f8, recovered = 3 blocks, err = 0
<5>[    8.933349s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4f9, name = .temp.t7N4AT
<5>[    8.933349s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4f9, name = .temp.t7N4AT, dir = 7e, err = 0
<5>[    8.933380s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4f9, recovered = 0 blocks, err = 0
<5>[    8.933715s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4fa, name = journal-1732203582.tmp, dir = 26c, err = 0
<5>[    8.933715s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4fa, recovered = 0 blocks, err = 0
<5>[    8.933746s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4fa, recovered = 0 blocks, err = 0
<5>[    8.933746s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4fa, recovered = 0 blocks, err = 0
<5>[    8.933746s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4fa, name = journal-1732203582.tmp
<5>[    8.933746s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4fa, recovered = 0 blocks, err = 0
<5>[    8.933776s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4fd, name = .temp.rIQKTq
<5>[    8.933776s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4fd, name = .temp.rIQKTq, dir = 7e, err = 0
<5>[    8.933807s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4fd, recovered = 0 blocks, err = 0
<5>[    8.933807s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4fe, name = com.android.keyguard_preferences.xml
<5>[    8.934295s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4fe, name = com.android.keyguard_preferences.xml, dir = 2a1, err = 0
<5>[    8.934326s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4fe, recovered = 0 blocks, err = 0
<5>[    8.934326s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 4ff, name = com.android.keyguard_preferences.xml
<5>[    8.934356s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_dentry: ino = 4ff, name = com.android.keyguard_preferences.xml, dir = 2a1, err = 0
<5>[    8.934387s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_data: ino = 4ff, recovered = 0 blocks, err = 0
<5>[    8.934387s][pid:263,cpu4,init]F2FS-fs (mmcblk0p42): recover_inode: ino = 500, name = com.android.providers.media_preferences.xml
<4>[    8.934844s][pid:263,cpu4,init]BUG: failure at /fs/inode.c:511/clear_inode()!

one file named com.android.keyguard_preferences.xml enter recover_dentry twice with different ino(4fe vs 4ff).
Maybe this error happened when deleted entry previous recovered.

Thanks.


> In the truncation part, f2fs_evict_inode starts with setting i_size to zero.
> So, the only possible way would be caused by enabled cache_only given by an
> inline_data case. But the assumption is that inode must have more than 2
> i_blocks, which is not normal case though.
>
> Can we gather more information to narrow down the root cause?
>
> BTW, I found that the below grab_cache_page() should be find_lock_page() to
> check its cached page only.
>
>>From a584542d25e7dfc91af53a8f4a4866b939d29fef Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 6 Sep 2016 15:55:54 -0700
> Subject: [PATCH] f2fs: avoid page allocation for truncating partial
>  inline_data
>
> When truncating cached inline_data, we don't need to allocate a new page
> all the time. Instead, it must check its page cache only.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a8aa6fd..0144ed4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -562,7 +562,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
>  		return 0;
>
>  	if (cache_only) {
> -		page = f2fs_grab_cache_page(mapping, index, false);
> +		page = find_lock_page(mapping, index);
>  		if (page && PageUptodate(page))
>  			goto truncate_out;
>  		f2fs_put_page(page, 1);
>


------------------------------------------------------------------------------
