From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/3 v2] f2fs: add bitmaps for empty or full
 NAT blocks
Date: Tue, 28 Feb 2017 11:34:11 +0800
Message-ID: <05bf84ed-1e63-3dd0-9c9d-a7b483a8a602@huawei.com>
References: <20170214020644.18189-1-jaegeuk@kernel.org>
	<20170214020644.18189-2-jaegeuk@kernel.org>
	<20170223225813.GH2026@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciYbU-0007WY-CD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 03:37:32 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciYbT-00017l-8C
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 03:37:32 +0000
In-Reply-To: <20170223225813.GH2026@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/2/24 6:58, Jaegeuk Kim wrote:
> @@ -2326,7 +2431,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
>  	 * entries, remove all entries from journal and merge them
>  	 * into nat entry set.
>  	 */
> -	if (!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
> +	if (cpc->reason == CP_UMOUNT ||

enabled_nat_bits(sbi, cpc)

Thanks,

> +		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
>  		remove_nats_in_journal(sbi);


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
