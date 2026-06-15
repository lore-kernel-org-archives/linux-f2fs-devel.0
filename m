Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C297ACD98DE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1jHgkvUW5Ksf1RqDmqYyzSANuRFhUfXDwf0Gs7jbEVU=; b=MHmlYR772JVgzuhrw1gEERFt68
	HsugCeolHeITeucaUZEMLIee2HtLPDXcFXCNdONLsByxrGGj5ifSASv0YH8RdJY/9a9sezF+GVo1D
	wse5bFaF2/9sCxuVdH0Q1vxJk2do7sxprDLxzTeTJfYdsfBEx/XrbetZzgsTstJXRlGU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ73V-0004NB-JQ;
	Mon, 15 Jun 2026 13:08:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ73T-0004Mv-Ta
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Raq7VNbdBNt9d4hB9e6oc4gfaUfydpebI3wex4IWKUI=; b=ROzqckSZhvQBgvgi619JS6uWrd
 Cuy9ZKPWuvKaZWIPqRIOrn6fCah/TYmoTYvpDbx3v1wkvmBOMpVoAJg2tuzkXZpPFN2azWAkMu6FY
 XstSU9c2u+uHNPwAGHTYNVBpMqQ8Fk9vGki+s+xsMQDmCSfWrVsvuH7+PpPj9rVtqOMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Raq7VNbdBNt9d4hB9e6oc4gfaUfydpebI3wex4IWKUI=; b=V
 G/GkSV4zg7aW9Z23UUZeuAlylZ31+vc1YLqCGkQ5J81EvSX2tsYJpndqx7KWtto3P184rWhfNC2UD
 zo/rxHChIvtDKC7cQKKeg34nZgyVCy3F0dHnNOV1NKKRuyp/ltvspVkVpLJlFmvahiGmQreq4CDfy
 Bz0sANI7VKYwARso=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ73S-0005wc-FF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 351BE6008A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 13:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F941F000E9;
 Mon, 15 Jun 2026 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781528911;
 bh=Raq7VNbdBNt9d4hB9e6oc4gfaUfydpebI3wex4IWKUI=;
 h=From:To:Cc:Subject:Date;
 b=fBUOLKXLl3qHlydK12wL105ju8FAnoFrKX1QA59SVgctTxQKHV80VxMfo+pnnxsjM
 mKrI+23yVF1JyJ46py+lAQmyj1XKj7OZl04AYptyrBdAywqQg4NmgTUGUhz7LkxwHD
 8ppfmrMl2rb0uXYNfr+pLQFELtvvG/HM8i3yQhDvhCJQUA22Ixm/dB08p9L2m4uXrf
 a+aC+PxK/lCGz/gO/WwgM4eWlc6V3wZH+jI0KRxKy/NlacHElCaJuXX7bIq/h4byA2
 uqV94yQvW+oRba5GZDmfqXYI3Avlh5FQ7tWv6Jc3CCNRfcXgN9N+rIMW+hsm5cX5z/
 5DiGgCI/PzUNg==
To: jaegeuk@kernel.org
Date: Mon, 15 Jun 2026 21:08:17 +0800
Message-ID: <20260615130822.2576088-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
MIME-Version: 1.0
X-Headers-End: 1wZ73S-0005wc-FF
Subject: [f2fs-dev] [PATCH 1/6] f2fs: fix wrong description in printed log
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch fixes wrong description in printed log:

"SSA and SIT" -> "SIT and SSA"

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 69e0a867219d..0e537508df20 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1897,7 +1897,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sum = SUM_BLK_PAGE_ADDR(sbi, sum_folio, cur_segno);
 			if (type != GET_SUM_TYPE(sum_footer(sbi, sum))) {
 				f2fs_err(sbi, "Inconsistent segment (%u) type "
-						"[%d, %d] in SSA and SIT",
+						"[%d, %d] in SIT and SSA",
 						cur_segno, type,
 						GET_SUM_TYPE(
 						sum_footer(sbi, sum)));
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
