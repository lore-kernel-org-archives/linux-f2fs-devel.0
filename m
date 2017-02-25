From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: no need lock_op in
 f2fs_write_inline_data
Date: Sat, 25 Feb 2017 09:58:58 +0800
Message-ID: <1eeed01e-f9f9-1406-cadb-eaf7938b8fa2@huawei.com>
References: <20170223123120.18842-1-heyunlei@huawei.com>
	<20170223194529.GE2026@jaegeuk.local>
	<0e037d54-9f45-d38b-da91-b5765fa83a62@huawei.com>
	<20170224195837.GE39009@jaegeuk.local>
	<ffdfdb1c-4a33-2d81-7776-2fd001cc85ec@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1chRfD-0005sm-GQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:00:47 +0000
Received: from [45.249.212.191] (helo=dggrg05-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chRfB-0005JM-TE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 02:00:47 +0000
In-Reply-To: <ffdfdb1c-4a33-2d81-7776-2fd001cc85ec@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,
	Can we add below to avoid this case?

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 80f9863..c4f3db0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1695,6 +1695,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,

         if (f2fs_has_inline_data(inode)) {
                 if (pos + len <= MAX_INLINE_DATA) {
+                       dn.node_changed = true;
                         read_inline_data(page, ipage);
                         set_inode_flag(inode, FI_DATA_EXIST);
                         if (inode->i_nlink)

Thanks.

On 2017/2/25 8:59, Chao Yu wrote:
> Seems when there is a large number of dirty inline data in page cache, then
> trigger intensively writeback and CP can run out of free space?


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
