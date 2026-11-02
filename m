Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C5606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QD689VDu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VfY6DfO4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RkKk0i9x;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTmu0Hhr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=MwOq+gPGUZ3IUdbVfdotFp7HbZoV0g+fTS/4MvEQg5g=; b=QD689VDuxMitBshAc8HhNmoEi+
	JE9havu/IDAJs+k/+fHsuxHSHd6EiWxq/kGyLmxfxfpsyeiJ0jc3gQ94tYc9aown2yHMuXiCIQnI/
	UQYe+KkDMDsVowu6Wh+uBS9rOWNeilRPB12Q0NcICrsp4bEarLTNSCJTtLh9LBCld/XA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu4-000000006qZ-1KV3;
	Mon, 02 Nov 2026 19:41:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtk-000000006p9-0fuL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/v1A7jUnmGOwntEyYw0zhVdD1xgsDIS+IQzdPhAISQ=; b=VfY6DfO4K14MCPTBWSji/rlDGR
 BiOlrXwjToEe8reisO/JuWshfFpy7hLG6w7js+NZyhbOVBHtW+JngMSFgE3148anpioVxKVp9P8rf
 HdKVdcgQOA0/g01CMq6jPGL/7rT6tEk3w10DjpG9E9fUUhd2JRlYtrfjWJGdX1mzTSFY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L/v1A7jUnmGOwntEyYw0zhVdD1xgsDIS+IQzdPhAISQ=; b=RkKk0i9xxThjohDgMiIsZ26NYp
 aKDip7FtyqzqDTkPaRe9ppqE34FO7oufn6BCT6IN+fnrx6tuC/DlxyW92W5sW/8AIiwv27OsxxLNk
 3vvE2t2vRAAYy3DxGp+LPtpnS1cyAFIerGfc8krrLQ5KE6lfa9OakjqiOFqRTfHpsxkM=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxti-000000002F4-1Hgf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:50 +0000
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cdb2893531bso821956a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648445; x=1794253245; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/v1A7jUnmGOwntEyYw0zhVdD1xgsDIS+IQzdPhAISQ=;
 b=LTmu0HhrrOpzhrLNmvKeuTQsC0p0QmBO60CLO2wH+m/vqPuRRIhMqFAoyLy2JvAKSp
 qdJZUjgSjBw9NMtavEX5oi38YFYaOygACTjUKYZr8JUJKe/UwhRDnRc60MFGKrb4LCaG
 9uXlnHd/wzWnyG/tJ3psPiguwuUF6aEaOVff8Npel2dg1owpWzS2zQvzRSyu6UlLrjpf
 AgAZgkMJ9prMIiEYVNL5/YqWj3kp1AlF92J7gyappVUkDauerKPMdS811TEkWPj0N9qp
 NC4ZgM44hwVTd4IJ/8vSkgCxh9KZPVd3ADj6kFq5C3r4WMKDdKg0JGHxtzej0jdui48N
 x7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648445; x=1794253245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L/v1A7jUnmGOwntEyYw0zhVdD1xgsDIS+IQzdPhAISQ=;
 b=QFepsTKAnijvI7QG6iZ4KGPAykuEu0OEAuBQ1MfD7CLWVDko1Ng0CSVXufuMeZ4O6f
 N7t8UjxRWrXYLnTvA6qiPxf4Ezdc6hjA+6UShKcc3yQ8iZ+3y88sy/3P8zRGb9o2qz1Y
 YCX/wgh9OscPGVffOcqbv5OPSwjQMH/2TlrzVGgwbDnyPdsfRgR1Y/Lb90nCRte6fzW2
 PrIqBOSOWLOubRjdl4YTMJW7vnsGNnhuGKyK3ytJ2XerxxwvlWCipeHT07NQUw/zPHvt
 Y4QGiIBtv73+ZJvyqnauNhRmoIxzlIsBuWInuuffJMbKOxjgn+BAA5QBmqZncYNnUnYB
 2Jcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXHU2Q4q+SukbrikbL5B2zazLT1WH3oOhuUGQDnUUNtFe5WGD2dijX4v6pFpDNPbtutYKLu/85vJgBtiec+pXK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKGZa3MezB3XEraFw/vSQ6La5rU+K2kY55sCC+REuQiH4+zXkSk
 6oVQo7BODO9H0VT/ycU/xRY+EwDlwVM0uDDV/hT3CXIIaZYcjEmnLk+Q
X-Gm-Gg: AYBFou0RasWNuT9FntBvEf1VfQru3yOrgDhzJ+ZRRVCKaTibHAU26PL8mlJKn180+6z
 TcbLSfxL6FDfCMZebAfCmfDUtF3leSHCgPNPRinGsft8GZS/e1ij9Cz8dN3+QzG6eV7E8kKqqn2
 tOjX9i/cH0bjtxmtMC+6VBVySvNw/gbJl1fK6gyHHjSIHOrVE1H0bYSmUYEuJ8+cZaKTkhlasDX
 7BkRUPjIhbAs05DffR4JlopsJEbZ9l7nsKH0uqj3r+WhIx376plFgi/JOiIyjia6ma0Wc42rh6C
 YXC0AB7LE8xjFXpMYwrs80LMz2j63VQ6JyN1LR50vL004aVBLkcX32m9d7NWq4Jt2YbV3eTB6bV
 bXLF0mzxh7j2WMDdCZiWVHSTk4smtJ8pheFSc/rtbEdG6UalwL/sH0Tz77gpXp+TrIHvad6U1MO
 equW68kyzxT7iWL83q5/E2nVDllBWCm49tOWR0iD1xnKyK+Ejo1Z8ehXnkYnFtKKIVmHGbBo/4d
 DZO6JliFIqXBzNmZZF7nL/3lrnt6Zf2pqsBaPnsmt4VxdupbnMwCJFzRaJKNuOXZqEfQbuwVK3f
 qRxGw8RFXPiqXYkg2x/j1pwoehhKNX3EwuwCX6fiSoqueBjSYnxCUpHT84DE7Jl6IlGDFr4alPH
 QTDUCR4OdAObHLtVbPuEFV2lrvZvrFAlO1JCeL8w5t6Wn2A==
X-Received: by 2002:a05:6a20:6a26:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3e928645db2mr10568197637.9.1793648444623; 
 Mon, 02 Nov 2026 11:40:44 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:42 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:52 -0800
Message-ID: <20261102193952.3002018-21-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxti-000000002F4-1Hgf
Subject: [f2fs-dev] [PATCH 20/20] f2fs: enable subpage block size support
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

All paths now handle filesystem blocks smaller than PAGE_SIZE, so stop
rejecting a superblock whose log_blocksize is below PAGE_SHIFT.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b2669057b7d2..4339e4ea7a12 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4173,13 +4173,6 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
-	/* Subpage block size is enabled after all paths support it. */
-	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
-		f2fs_info(sbi, "Subpage block size (%u) is not supported yet",
-			  le32_to_cpu(raw_super->log_blocksize));
-		return -EOPNOTSUPP;
-	}
-
 	/* check log blocks per segment */
 	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
 		f2fs_info(sbi, "Invalid log blocks per segment (%u)",
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
