From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: add a segment and section num check in
 sanity_check_raw_super
Date: Sat, 26 Dec 2015 10:55:45 +0800
Message-ID: <567E01B1.5090207@huawei.com>
References: <1451097979-4589-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aCf1u-0005cE-53
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 02:56:26 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aCf1q-0006ZK-SF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 02:56:26 +0000
In-Reply-To: <1451097979-4589-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2015/12/26 10:46, Yunlei He wrote:
> This patch add a mismatch check between segment and section in
> sanity_check_raw_super.
>
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>   fs/f2fs/super.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c3070c1..b51a690 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1036,6 +1036,17 @@ static int sanity_check_raw_super(struct super_block *sb,
>   		return 1;
>   	}
>
> +	/* check seg # corresponding to sec # */
> +	if (le32_to_cpu(raw_super->segment_count)
> +			* le32_to_cpu(raw_super->segs_per_sec)

I am sorry that here is :
			/ le32_to_cpu(raw_super->segs_per_sec)
> +				!= le32_to_cpu(raw_super->section_count)) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Mismatch seg num (%u) and sec num (%u) \n",
> +			le32_to_cpu(raw_super->segment_count),
> +			le32_to_cpu(raw_super->section_count));
> +		return 1;
> +	}
> +
>   	/* Currently, support 512/1024/2048/4096 bytes sector size */
>   	if (le32_to_cpu(raw_super->log_sectorsize) >
>   				F2FS_MAX_LOG_SECTOR_SIZE ||
>


------------------------------------------------------------------------------
