Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB64606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kqnQv5yf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z2tQzBaG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=htNzODXa;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xt38rl/P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=bF1PfTO6DvB1RD8QFK8hitUROetnis7nTFiS6J2fQuU=; b=kqnQv5yfvqTAdhQ04RsEABKWcJ
	KrVGxnsAOZFTTTgW9r9gIAIy7rO96Wmy3YJjUxjc0sgwa76srAZHkwdz+5Js7kcTnJW8uJfXDwBBf
	Se5hoYsm5Z+S8cdOC3dMEj9HMCE06vKakWukm6MTyxUIxoq1xKts56jAv4SUO1IE1xfk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJrbO-000000006mK-2yfE;
	Thu, 22 Oct 2026 12:08:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhijunli.leo@gmail.com>) id 1xJrbM-000000006mD-3VWX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:08:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N+7K+g7Y1asdLnQHE4wpaKr3SeOPLMqo9gr+h5TTsW4=; b=Z2tQzBaGz6W1WSFYLhEq8j7diu
 ZvhuxlP0r8aMZNIHmdSTqV+pQkyXSDjk3v9uuDt/BKupuqrQ+Q/I9OSF4PIEKdUTFVHXSpaswvG7v
 HgjAh++Mi0bouJnorTeNB+tMdG1Br5Eaoc8DgpIOLsBpXkLP6XpgaV61Df2NnbQf0MDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N+7K+g7Y1asdLnQHE4wpaKr3SeOPLMqo9gr+h5TTsW4=; b=htNzODXaKvI7p5XpI3MZ0/C5iJ
 wulY4C4D8o+7Lt1GRVz0x8xRp5WbWz0A9UoxV7U3VbT7Tbr7tpqvIHTxLTCPkNxO6oQT5IfyG7CzP
 w4jt7KPGtTW74TdW1/cHno3FR+gLgVBneLWwn5i+IWsHVbcEwOgOz5CPVcsNIF+6UKvg=;
Received: from mail-dl1-f51.google.com ([74.125.82.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJrbL-000000005ao-12h5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:08:56 +0000
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-156cbe59622so1456249c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792670930; x=1793275730; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N+7K+g7Y1asdLnQHE4wpaKr3SeOPLMqo9gr+h5TTsW4=;
 b=Xt38rl/Pucr28d4anGuwmNIO7CSzlRXVVFlFjt0gz+d2ZmUcSOGMo2zg6jIgphvzXG
 FI89OBs/SDMKZ76AiW7mLHQ4MUqzjcRhypJDew1uozC2b3vuxZ7FVOfC8g52+U9XEhY/
 klKT96WkhNTaMtek6swkyBsKnFSOXKnfhbiwETcki/HWWq426WvcpztiUJzNAwuDgIaW
 LhhQM5MR1FwOyWXRx/V3Zh2RR3VwbfYN5J4vMQRTOnWSvf+v2fv7xdbi6VK0fxOiU8/t
 71tIz36QQZJFIuf4tP/iZh7o9nuwIwP4m2HvHMZ6rx1A4PhAUITfyGVvT+asbZPE1cdW
 ImWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670930; x=1793275730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N+7K+g7Y1asdLnQHE4wpaKr3SeOPLMqo9gr+h5TTsW4=;
 b=cFHf7/an+tnwOJZWDw8XQYLjIYXkT5ejZKkY18IotLlCM77NXPEOPKGXPajka2oH7o
 Ns3JVg/Xuht9YUqmoIaEQieSEoLioa0Fu4c0BhtjKComBxoR/D8EOTLhfOoYCYZgO/NA
 ax9OiROcILUjImfzxBZ7tGQt+NV9EmW82k3rQmIj6dBK2ArsV2zxt+zufU0ZVt2lLwg5
 e6ZtyABoczHDDf1xccvY7LIosAzsaYTuk+PX8Wii8nKa7zyhAHeZlu+zocIib65w+F9Z
 HH7tARx1ZpiT8vo1XHsOGrmkCmnffxaKo0FcSO6+3TW0clL6/xvBVO3Drxnn9zmbQsRJ
 7IgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQoEaXiQMdPpNjP7ZXxKpfzxCrnrCTPxYNFBBAtL1SD3tYZIs6gutP9UuPZBjOYMPHEm/hxPo1qRnNUjhY1FAb@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKVjYv3zmgUhhVLKylBEONby9QqjWge798VD90L6lAZHZ+ljGWI
 MNv5H2QRHK8v+GDjQNV5+21Imq0DsX+VLoRUwnLagpBN5ceA/jQWL1UZ
X-Gm-Gg: AYBFou0Bf8rkN2+2+gjuz5Wl2djOcNnHO4ZjjnsxLCilH7yMtTEMNOwsBxAQdjb/X8Q
 0Rd+ywWiSg2Qd4TCiCv+jzApIKuksVTuziwWPeja0MbIAeQ718C9OaQ9kZj9nsbv8LUcDyOk4j8
 thrm1SU+nGHC0ruNpE7riqkcWUeXpbxqJpnOsJaHcdUMeIoOYVqiWffSDH6qJYUN+RLxGSxgCta
 omXswbChHEmAEsPst6Op65B9A7cgT42fGYy8pn7Fmz1E2y1S41mmwl/5+c87qgnCfCA86tkbzjw
 Wz+U9A108X6RRgfL1rZjqJ/fiSpByM3owEXPoMX8bcbxWdU/fusvSUBBeAn2du2nl3ZAJ4NQbbJ
 VbMKtYR2zgb/jKERGJJmWgoS0u91tS0qil/7WD+sBVw2lNRTWhP7L269h29ALi8/fS21dfI2pXt
 ROXEua+JdQjeFJJhZB5y9I7kr+fdh/ow0U3kM1npYPR52Yz+0vp+xzZlGgSaaI24LD0bDfeMhUZ
 YRclUuXZ9c3U0lkkh1G16fSTwtMJzBnjjqnTAzT7d3fvDZ42oUovER2QAA=
X-Received: by 2002:a05:7022:f85:b0:14e:d0ba:7569 with SMTP id
 a92af1059eb24-190a0612740mr8360111c88.6.1792670929457; 
 Thu, 22 Oct 2026 05:08:49 -0700 (PDT)
Received: from HP-Pro-Tower.mioffice.cn ([43.224.245.243])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903e02901fsm14930176c88.22.2026.10.22.05.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:08:49 -0700 (PDT)
From: lizhijun3 <zhijunli.leo@gmail.com>
X-Google-Original-From: lizhijun3 <lizhijun3@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 22 Oct 2026 20:08:32 +0800
Message-ID: <20261022120833.1698722-1-lizhijun3@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJrbL-000000005ao-12h5
Subject: [f2fs-dev] [PATCH] f2fs: fix to roll back SIT update on segment
 allocation failure
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: lizhijun3 <lizhijun3@xiaomi.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In f2fs_allocate_data_block(), SIT is updated before segment rotation
since SSR needs the latest valid block information:

	update_sit_entry(sbi, *new_blkaddr, 1);
	update_sit_entry(sbi, old_blkaddr, -1);

If the subsequent segment rotation (new_curseg(), change_curseg() or
get_atssr_segment()) fails, it jumps to out_err and clears *new_blkaddr,
however, it does not roll back the two SIT updates, so that SIT may
record that:

- the new block is valid even if no data was written to it;
- the old block is free even if a node still refers to it.

Not every failure stops the checkpoint. For example, change_curseg()
returns PTR_ERR() if f2fs_get_sum_folio() fails (e.g. -ENOMEM), and this
path does not call f2fs_stop_checkpoint(), so the filesystem keeps
running. A later checkpoint can then persist the inconsistent SIT, and
the old block may be reallocated while being referenced, causing data
corruption. The same stale SIT state can also be exposed when pinned
allocation returns -EAGAIN and the caller retries the allocation.

Fix it by tracking whether SIT was updated and rolling back the two
update_sit_entry() calls in the error path.

Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")
Cc: stable@vger.kernel.org
Co-developed-by: Chen Zhangqi <chenzhangqi@xiaomi.com>
Signed-off-by: Chen Zhangqi <chenzhangqi@xiaomi.com>
Signed-off-by: lizhijun3 <lizhijun3@xiaomi.com>
---
 fs/f2fs/segment.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b712d3d599..033a3b8bf426 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3908,6 +3908,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	bool from_gc = (type == CURSEG_ALL_DATA_ATGC);
 	struct seg_entry *se = NULL;
 	bool segment_full = false;
+	bool sit_updated = false;
 	int ret = 0;
 
 	f2fs_down_read(&SM_I(sbi)->curseg_lock);
@@ -3958,6 +3959,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	 */
 	update_sit_entry(sbi, *new_blkaddr, 1);
 	update_sit_entry(sbi, old_blkaddr, -1);
+	sit_updated = true;
 
 	/*
 	 * If the current segment is full, flush it out and replace it with a
@@ -4027,6 +4029,14 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	return 0;
 
 out_err:
+	/*
+	 * SIT is updated before segment rotation for SSR. Roll it back if
+	 * segment rotation fails.
+	 */
+	if (sit_updated) {
+		update_sit_entry(sbi, *new_blkaddr, -1);
+		update_sit_entry(sbi, old_blkaddr, 1);
+	}
 	*new_blkaddr = NULL_ADDR;
 	up_write(&sit_i->sentry_lock);
 	mutex_unlock(&curseg->curseg_mutex);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
