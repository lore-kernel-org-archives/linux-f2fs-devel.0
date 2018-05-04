From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: allow ssa journal with nat bits enabled
Date: Fri, 4 May 2018 08:27:03 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F056548D29BFE@dggemm510-mbs.china.huawei.com>
References: <1524643015-13256-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fEW3j-0005Zv-UT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 08:27:19 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fEW3h-003yJU-Q3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 08:27:19 +0000
In-Reply-To: <1524643015-13256-1-git-send-email-heyunlei@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Zhangdianfang (Euler)" <zhangdianfang@huawei.com>

Ping

Thanks

>-----Original Message-----
>From: heyunlei
>Sent: Wednesday, April 25, 2018 3:57 PM
>To: jaegeuk@kernel.org; Yuchao (T); linux-f2fs-devel@lists.sourceforge.net
>Cc: Wangbintian; heyunlei; Zhangdianfang (Euler)
>Subject: [f2fs-dev][PATCH] f2fs: allow ssa journal with nat bits enabled
>
>This patch enable ssa journal with nat bits, which is
>benifit for nat metadata write.
>
>Signed-off-by: Yunlei He <heyunlei@huawei.com>
>---
> fs/f2fs/node.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)
>
>diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>index 681552b..220110a 100644
>--- a/fs/f2fs/node.c
>+++ b/fs/f2fs/node.c
>@@ -2446,7 +2446,7 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
> }
>
> static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>-						struct page *page)
>+					struct page *page, bool to_journal)
> {
> 	struct f2fs_nm_info *nm_i = NM_I(sbi);
> 	unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK;
>@@ -2457,6 +2457,12 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
> 	if (!enabled_nat_bits(sbi, NULL))
> 		return;
>
>+	if (to_journal) {
>+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
>+		__clear_bit_le(nat_index, nm_i->empty_nat_bits);
>+		return;
>+	}
>+
> 	if (nat_index == 0) {
> 		valid = 1;
> 		i = 1;
>@@ -2494,8 +2500,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> 	 * #1, flush nat entries to journal in current hot data summary block.
> 	 * #2, flush nat entries to nat page.
> 	 */
>-	if (enabled_nat_bits(sbi, cpc) ||
>-		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
>+	if (!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
> 		to_journal = false;
>
> 	if (to_journal) {
>@@ -2535,11 +2540,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> 		}
> 	}
>
>+	__update_nat_bits(sbi, start_nid, page, to_journal);
> 	if (to_journal) {
> 		up_write(&curseg->journal_rwsem);
> 	} else {
> 		scan_nat_page(sbi, page, start_nid, false);
>-		__update_nat_bits(sbi, start_nid, page);
> 		f2fs_put_page(page, 1);
> 	}
>
>@@ -2574,8 +2579,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 	 * entries, remove all entries from journal and merge them
> 	 * into nat entry set.
> 	 */
>-	if (enabled_nat_bits(sbi, cpc) ||
>-		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
>+	if (!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
> 		remove_nats_in_journal(sbi);
>
> 	while ((found = __gang_lookup_nat_set(nm_i,
>--
>1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
