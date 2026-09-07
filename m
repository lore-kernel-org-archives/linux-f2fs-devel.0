Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638A6C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfcXFWC17JGjGC8iIrbadVokz4PRRhtHXTZTrZxIxto=; b=LKXkSXLpG6uapvBrlZtcMK6gSS
	Bm8ya7J/rGpnWtG2edz+j6hCi509BkdJvtqlkP/cf47s+8BPpnmmyelLmkz8/X0mLLyx/zhLvE0Yt
	6peskbIjv5F8u9LBbPsRhX5GUoTG3L0qWNrG94Ep9iRGw2rPUFU3Pmo/VcCjThdMiWaA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3Xzo-0005Lf-Li;
	Mon, 07 Sep 2026 11:58:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3Xzn-0005LT-GP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NLEMjkf0TBn+Gk0VGOED7cVkR/se4a7yHw0GAA0vsQ0=; b=R31DSBQMaUHzHw10MUaDncDuJx
 FJj4ygMxx+RN9JVZAXncwDgNEbMTO5I2elScgcqHRB6ZhJvl15sCRiRJQw0OPNodB85oSkXWES3/B
 rx40D+dpK5u4jRopP/qi77B5tfz6zhm/wuKNW/1hVTGuPJ4+ihIk/Nr92r96JBH8YxkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NLEMjkf0TBn+Gk0VGOED7cVkR/se4a7yHw0GAA0vsQ0=; b=DhyGHG0dyiD9AXH6cnvd5HP9sa
 koNflK2acpN+ong4Senp0B0DyKLVBBwKj43jnFxz3F8w26QcYIN8Wlb+LkziYsb2Jd9Xitz+DXe8D
 iou0HwFA9v6KemSAthpGfPzVMdG3/TbxmtBTn45WGGrpU7z5yoGy7D9nrzFNxuVpgH0Q=;
Received: from mail-pj2-f4.google.com ([74.125.227.132])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3Xzn-0007Vr-T8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:58:44 +0000
Received: by mail-pj2-f4.google.com with SMTP id
 98e67ed59e1d1-3896ccc93b5so994749a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 04:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788782318; x=1789387118; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NLEMjkf0TBn+Gk0VGOED7cVkR/se4a7yHw0GAA0vsQ0=;
 b=DOUn4hjzFSWXJl13oNfIr0CyHJaf+KYUzRWrfqW0dnWsF+xxXlW3PZ3i1JGjmzPHEd
 P+Fd3u9JlkqI1zaNCcDZKREw0u3M6KnFpcJOJwC55LR2GWmzLhb1qM1tD1J5lu6egwrn
 aXbMJmOGEwOBsitBXsPDQSmmWr5W8T61L5a2Htl/+We8Ptq8EIuQs46eW1xjcx6DRpgt
 Zu9ChSW3hdhiT2BK5e9Y/djdYLB6GG4Rfv/r+VRlXHaOBXf+iKzTGOvRFhEPmNaKBBMP
 5YgBwDnDfGutEzcFohuNMvqH1+6sPUMDp8Dqb6WXrdlYqAt4Fwg/4/2KxlAhCWjFsrcJ
 dWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788782318; x=1789387118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NLEMjkf0TBn+Gk0VGOED7cVkR/se4a7yHw0GAA0vsQ0=;
 b=IYHMz/oYKV4Jtf3aqPhXqU1t8cOCdalr3w8Wyo1aI85JVXGvr7Mbgc3IHtMrkqAw8u
 V+8r89hSK7E0UBsv05Eld30SjcLw8eiQjcpctf10IRq48Tev0bcRbQNPd9JoPMZSXfzK
 M8gQhbFzps3XXR7rdMioEzyCzERFHlisSjY2c/Y1fGr0SrzHJUxOVpmfIydCCjdgxrBh
 7G3BMomS1piZbHVlyWU6OJIEekREzCQeKwQXPrAv3CbryDfm5otkKpp3Pg6f+8JsJCUX
 zmIElVkFwTccmXj+eb+k95HCY0tsVFyuT5s+6XIpWYRTMp/Axnx8vwk0DOKzgXk1zVbw
 Vlrw==
X-Gm-Message-State: AFuF++mdHk5QONPGnQATYpfU5shyi0VH2QldfusJyH57VziG2zeb+FxR
 vyUEQm9MSY7q7OLZnVN5O2QKWyEqGmWRDj5LtjmTosvShecI0E2SSoTQ
X-Gm-Gg: AYBFou0HUYgVWg58uUAgQNzVKsXYWHcDi+aX6Yq0fA9e4TZu9SYR27KtokY5Sex6AIS
 +2yHFLlVmlJM1YkCq6+spfQ6jomz0ggWhWXGZeT5No0j03tXFfBIquFfv3nj9UsIeUE+PNkYfnu
 dV6iUDwM2GY/QRBfEJr1m1Bm2Hwp3pguckgn5au+gctr7AhXROrvw8QJV7waaZ+BI43K3ti3NBS
 SBmoVWVTbNdAup8l8GoAdgBhfNYKH9XOi7beN0gFPEwLXWVgJ5Y8Nj+U0g/7elKzmxe6DyMz6RX
 0/phrfJgjxbNZxiMXWWwEaWbcolUxN2rQ7RJYqzsfaOs1qTiWCx5YYjKcjvUp1ZUsh0+H3gEUUn
 wFC2zg14CnrlZ4GW7w0eYCdiLSbQ00j3aPdif63cD9J66NjGge7ACyHu/G++06kwb2uYOFkhFe/
 2Mgt1AQpxPL8Eq7N208riAClgwrW8FddRMXmGIDBcFT2ik97E22Ho3zy2MV3x7R2KX6JW5vaMcN
 jYVs8YFkIUWHuCybEh4F4V4wQ==
X-Received: by 2002:a17:90b:560e:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-39b261e7931mr34668453a91.14.1788782318154; 
 Mon, 07 Sep 2026 04:58:38 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b813fb4ddsm2668667a91.10.2026.09.07.04.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:58:37 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 19:58:31 +0800
Message-ID: <20260907115831.2561825-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
References: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3Xzn-0007Vr-T8
Subject: Re: [f2fs-dev] [PATCH 03/14] f2fs: support regular file buffered
 writes
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 27 Aug 2026 16:56:53 +0800, Chao Yu wrote:
> Can we check this out of f2fs_ffs_test_blk_uptodate()? and add a sanity
> check here:
>
> 	f2fs_bug_on(sbi, !folio_contains(folio, index));

Thanks for the review. I'll move the check to the entry of the function
and turn it into a f2fs_bug_on() sanity assertion like this:

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
@@ f2fs_ffs_test_blk_uptodate() :
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned int idx;

+	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
+
 	if (!f2fs_folio_has_ffs(folio))
 		return folio_test_uptodate(folio);

-	if (!folio_contains(folio, index))
-		return false;
-
 	ffs = (struct f2fs_folio_state *)folio->private;
 	idx = index - folio->index;
 	return test_bit(idx, ffs->state);
 }

Does it looks good to you?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
