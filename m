Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05CDCA0EE7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Aug 2025 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scj8KacnMZRnIj9oANcBNfgdXLIUrKpq7xeg1RLYNcA=; b=nBAe3ciG6mUP1Xxr/Z62Rzj/yD
	ohIjuBmpFzS9AQ+rMSHGniKd8FRt7wjkuF5GWjuR9fUgxQMCIFZLTNoi8z12KWjLCLWPsazpO9gU8
	BkLGJXQ0Laz91QkIDqVG2Xho+2A1kyGcO9ztYQoRtdjKj1OdY3ui12gff3AtBqkhdQO4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1um7wa-00045w-O9;
	Wed, 13 Aug 2025 09:38:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1um7wZ-00045g-BF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Aug 2025 09:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jDEv8IL/23nGWQ3lTXpOICy8DllsO9huiCSCaNsxpfA=; b=ZLFOoODOBSD3Y54FoKfyfRFhAI
 PqsPfcohk1U0K0dvNBEHcR/VEnX3rPsT2vQfoeMIFl/Pm9CWSKunekGMpDT3tzKrsdF3WeBilyyJp
 j6a5uJe141zcnOtDuxcKjWOnphcOUVyZTni6zOtRfD0v/pywBLd15bvB8DgZyMdG7olU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jDEv8IL/23nGWQ3lTXpOICy8DllsO9huiCSCaNsxpfA=; b=f9EKuxMxbvVjL8KudEpr2dkL7c
 FgMeKG4TM8GEa4V3I8BapKlTu7xaWIcfPR1Yx7Ub0bHrhersR0cbzDfjEhHMRD0gcxUWd0JTs83O4
 C3oyL0Ux2/DHMUHkhQJfMsqNsjkEPO4Q/mee5oIcdPPxGoDrHQvuHZI/2u9nKa39wIq8=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1um7wZ-0004Uu-4B for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 Aug 2025 09:38:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jD
 Ev8IL/23nGWQ3lTXpOICy8DllsO9huiCSCaNsxpfA=; b=LfszXlop2m5pDvBNJP
 q6yF4z/A2hHRqWrU0gtM6tB+ozTVEirNHkjuOBc8dbsJvU9nvJmM1CcoQU68+w3/
 qiS9ur4B5MVDVS4K7TRaj1bb95uhkME1tsFLZRqZqIZD8wcCjIohyCLsnz7M9552
 6qOA582+k+m2yN2HkR9wFSj88=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3tyv8XJxo_MzyBQ--.54250S6; 
 Wed, 13 Aug 2025 17:38:25 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Date: Wed, 13 Aug 2025 17:37:50 +0800
Message-Id: <20250813093755.47599-5-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813093755.47599-1-nzzhao@126.com>
References: <20250813093755.47599-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3tyv8XJxo_MzyBQ--.54250S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xAr45Kw1DCF4UCF43GFg_yoW8Gw4rpF
 yDGFnYkrs5W348Xas3tFs5Zw1Fk3y5G3yUWanxCrWxtw4fXr1FqF4rt3WDuFn5trWkJ3W0
 va1YyF1rZa15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRm-ewUUUUU=
X-Originating-IP: [58.240.165.118]
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiEwqoz2icVjtiDQAAsI
X-Headers-End: 1um7wZ-0004Uu-4B
Subject: [f2fs-dev] [RFC PATCH 4/9] f2fs: Convert outplace write path page
 private funcions to folio private functions.
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Nanzhe Zhao <nzzhao@126.com>, Barry Song <21cnbao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Yi Zhang <yi.zhang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

    The core function `f2fs_out_place_write` and `__get_segment_type_6`
    in outplace write path haven't got their legacy page private functions
    converted which can be harmful for large folios support.
    Convert them to use our folio private funcions.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/segment.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 415f51602492..5589280294c1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2637,7 +2637,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 949ee1f8fb5c..7e9dd045b55d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3653,7 +3653,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 			return CURSEG_COLD_DATA_PINNED;
 
-		if (page_private_gcing(fio->page)) {
+		if (folio_test_f2fs_gcing(fio->folio)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
