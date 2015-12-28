From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add a segment and section num check in
 sanity_check_raw_super
Date: Mon, 28 Dec 2015 15:10:56 -0800
Message-ID: <20151228231056.GA65529@jaegeuk.local>
References: <1451097979-4589-1-git-send-email-heyunlei@huawei.com>
	<567E01B1.5090207@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aDgwU-0006fJ-5L
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 23:11:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aDgwS-0007H7-3W for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Dec 2015 23:11:06 +0000
Content-Disposition: inline
In-Reply-To: <567E01B1.5090207@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: He YunLei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On Sat, Dec 26, 2015 at 10:55:45AM +0800, He YunLei wrote:
> On 2015/12/26 10:46, Yunlei He wrote:
> >This patch add a mismatch check between segment and section in
> >sanity_check_raw_super.
> >
> >Signed-off-by: Yunlei He <heyunlei@huawei.com>
> >---
> >  fs/f2fs/super.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> >diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >index c3070c1..b51a690 100644
> >--- a/fs/f2fs/super.c
> >+++ b/fs/f2fs/super.c
> >@@ -1036,6 +1036,17 @@ static int sanity_check_raw_super(struct super_block *sb,
> >  		return 1;
> >  	}
> >
> >+	/* check seg # corresponding to sec # */
> >+	if (le32_to_cpu(raw_super->segment_count)

			raw_super->segment_count_main ?

Thanks,

> >+			* le32_to_cpu(raw_super->segs_per_sec)
> 
> I am sorry that here is :
> 			/ le32_to_cpu(raw_super->segs_per_sec)
> >+				!= le32_to_cpu(raw_super->section_count)) {
> >+		f2fs_msg(sb, KERN_INFO,
> >+			"Mismatch seg num (%u) and sec num (%u) \n",
> >+			le32_to_cpu(raw_super->segment_count),
> >+			le32_to_cpu(raw_super->section_count));
> >+		return 1;
> >+	}
> >+
> >  	/* Currently, support 512/1024/2048/4096 bytes sector size */
> >  	if (le32_to_cpu(raw_super->log_sectorsize) >
> >  				F2FS_MAX_LOG_SECTOR_SIZE ||
> >

------------------------------------------------------------------------------
