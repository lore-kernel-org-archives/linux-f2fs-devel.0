Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E417606A69D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C5URHyD3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OgyRQD7F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D83kdyg6;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iFqE8TjG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=KdxPloMuyNDR30HbOS5hjoq1XVzKX3lP9l2XH+fN4Bk=; b=C5URHyD3lVJnN92n9IO9MHUNjT
	5PDmwodSWdDVTgKfMKPc8TUvaK1CVIVaTE5rbLcJaCnnKYNVgnL5Wi1UCCrKADLOw0P9tzWJ1IQuD
	XeRQJQ9aXVt9OpbRX14SAOpo3gYL//tUfSseA0BdONEoL35bXATLYgzh06SPYmi27zRQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWrdk-000000003LR-0zBP;
	Fri, 27 Nov 2026 08:49:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <qwjhust@gmail.com>) id 1xWrdh-000000003LL-43KQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 08:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=; b=OgyRQD7F+4jNg8Mu2FiPN+b9if
 mGabsdg8v1h/URURph63JhJLVABuJQI7gU/SS9P+YIBAemV8jmrQ8U9EQno3+kuOSZnVzDg5Pt5pW
 euGfolr66G0Y02m02tZ0hntjEX2WuBU/V8c04dklOV7HMKw9h9FHrgxnwxcYnWlu3XpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=; b=D83kdyg6hFiDEwVoOe4Hmz0pRL
 9f0tP4yUml9BGh0rhZz7b26h5yzU2lUNZGtYIosi2IvfLGhdfHbuoFBYnbAQg2+XN/COtJxxy6Hls
 SxgulaJ5NJgPhSuWtakVJgVF4Q1SscO57D8wVim3cTo92x03z/ZBddQ72KBVdDHvjkVU=;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWrdh-000000001sK-1U0M
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 08:49:05 +0000
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2f046b0adc0so44898105ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 00:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795769340; x=1796374140; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
 b=iFqE8TjGsyzR9NRnElJdsvl0VHA0gMqIVQAWyLUgU+fv6SjFutKvDxc1BFt01cY0FZ
 j0tlLPh7Yxe2+X1lVrQ1HXJ6Ri/4fPeGMWi5GBvhMwJC9Et592q1JcAeCamwjInzHaru
 HiFJ4oXvOWx0dmK65YGmj2yFyyRERHUh/ScyWUqtuzIfe1maj/JkAM3eaqOikGAAWGjL
 vV1qrlS3VFz+gYgdmzc1xn1ESNbb545yYkCX65IvDWMRIFoCTodZiIoob3nqFhI7SDhl
 XcRIOUJlaqwwOLO6A2WwOANEmtO9J54kJxmND4+ARjhVs7ij/bo9TwK+Iq072wjGeqn/
 9X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795769340; x=1796374140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
 b=Kdex57ImY9n0Ju4i1E7fIwOKaCqP8bvycCShWGgQKKYaKW3w5YTfo3VS+u/rUVKY5U
 IGG5B/5SDtiBSJKBiRskr35SgT+ipXRLGbNGFjTlt/DWRuFqGERlYbvzMWE8KI8DfVTd
 Q2NTHXxZmoHE5zqzqb9PrCH96xTlmBAis+QjPOUSonuMpPwv5rSRdI6SJ3RsAHg0f/3Y
 6clv7yK8KVx8zz0ob+2PSdI3TOpBtEpOomqkA3anQd/sYjLbKyQpTs8Iom9lmqugOhZt
 vhdX6XgzbuEEjeIQDAd/z+q0rSSjX+WG1fuBlvQM2n3UtVqkQlLA5qPjSiV6WYIr1yT1
 tVSg==
X-Gm-Message-State: APuU4Z+ZAhAiP+j/f9kaPX/a/tW2vNyzZYsq3oIduFp6ObZLIdRaRYNA
 VONqhQIfLhFOHIJfO98EXICb3EwCbG88V5MMMD7K13wP/s7w28MuFZyD
X-Gm-Gg: AZFdTZeyiwGpk1aI29womVlajXEk/m2S/RTkns+FCtamFJjg6iT+ypKxIYjXGs70JYT
 n8JxzpMrIHpTILuhAzRSyE+3661kj4sTx568SJMkZbslJicUTbRyl4uqwOwVULF4dAcd/X/SQ5X
 8lYY16LtTH99SIJ5lvqmePSAZ/kBYsizXL+vR6eXpqtlNhV+IZchM5hPRABgE2e5UozZOqf81Ig
 Gf3pa2shXR/AA4ocTqvLBO6qKOHkZBD6oz8yS+ene/NDC4IXYsSES0m4fwmlsTUQm6tq/BG4p9v
 9aJOKkuH6SV2toCUoLVIYsfQLIMnQn5V9irxDT3nytMxVEHBuSa+ou66ACiQfy+MyyGMKgBjFmw
 H0fKN8GghdjWFx9sEg6/1nA5QVrE4wrT1iHMUuUnb6/Rv2ZpfdrjPhZJo+RHlMWl0QJJjLQRxJA
 C8K5ym9cWGOyGJx5jBXmRzf63Fw1JX2IuJrdv8/ro5FNumW6OjUty2JINUz6CJdKL2HkzlzUgkj
 PJCf0I73HRqbzdSpOe+vGtfUGXO9ChhTcXANS0efWzzqcmXZHnVngKfspOE+wHlBMESWCtz/v3D
 htcOMWJ9IxOD2STV8QWY1Od3DyoT/I63Vtz/dn3d2YasG2n2/Asyea9fHnb0MsYoLw==
X-Received: by 2002:a17:903:22c8:b0:2ef:e563:d2a2 with SMTP id
 d9443c01a7336-2f11414c317mr10473615ad.57.1795769339572; 
 Fri, 27 Nov 2026 00:48:59 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 00:48:59 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 27 Nov 2026 16:48:44 +0800
Message-ID: <323235fbdeb5131f83569541c602ddc88f412b18.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795746008.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <cover.1788795700.git.qiwenjie@xiaomi.com>
 <cover.1795746008.git.qiwenjie@xiaomi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWrdh-000000001sK-1U0M
Subject: [f2fs-dev] [PATCH v6 1/2] f2fs: complete dropbehind write bios in
 task context
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark dropbehind write bios BIO_COMPLETE_IN_TASK so the block layer can
defer their completion to task context before folio invalidation.

Allow normal and dropbehind folios to share IPU and OPU bios. Set the
flag after a dropbehind folio is successfully added, checking the original
page-cache folio rather than an encrypted or compressed replacement.

Exclude metadata-cache I/O, which may not have a file-data folio. Leave
the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v5:

- Rebase onto dev, preserving the updated bio_len/bio_offset merge paths.
- Skip metadata-cache I/O before testing the original folio's hint.

 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..37d74afc8b26 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -624,6 +624,9 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && !fio->is_cache &&
+	    folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	F2FS_BIO(bio)->entry = NULL;
 	bio->bi_private = NULL;
@@ -1077,6 +1080,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_lblk, fio) &&
 			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
+				if (folio_test_dropbehind(fio->folio))
+					bio_set_flag(*bio, BIO_COMPLETE_IN_TASK);
 				ret = 0;
 				break;
 			}
@@ -1359,6 +1364,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
+	if (folio_test_dropbehind(fio->folio))
+		bio_set_flag(io->bio, BIO_COMPLETE_IN_TASK);
 
 	F2FS_BIO(io->bio)->entry_cnt++;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
