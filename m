Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3302CC5B552
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Jun 2025 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqZn47FzQuI9sD9QOLSYLhHAObLl7wD4zMWxMWI4/cY=; b=ca32dr94+Kd8Ts3vbqfxoWfEm0
	H0sKgtH38b83yWrvaBgyiWHoAYoGZggbxDVQeDQsKca6VSF5UXZKKEDPguezjEJ524BaWG31aaGxN
	Ra5X2BHCj5Cn9pO1yLJlVYjgvt50H21nKUYfqIQvaDOfb1y88gWfAnCPSis8cwV4cVN8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uP0hq-0005u3-Py;
	Tue, 10 Jun 2025 15:16:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <shengyong2021@gmail.com>) id 1uP0hq-0005tu-84
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Jun 2025 15:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zNb4y/YgvMlqcunoawqZQihEjbHUq2NWUz+26/0fBXc=; b=TER6+YmDuxlBezXjgsV40dwdCc
 2z4zXJKXmPYZIdB55upqpLWzrjnaWoXkPsJFONzWAFY2nciVtuS5t62cYcBqz+dejamT3y3gz4xKX
 rfU3d3X38taPa1bsU64hKOW/UMxlsOIEmT9V+SpA8kfoMUOev9Ot69LbJhqU4RxfH6rQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zNb4y/YgvMlqcunoawqZQihEjbHUq2NWUz+26/0fBXc=; b=AmHqR5FqVOq/Ux8s0Y4u/BmNbG
 rdP0g2AxtX02SIHbMyOSUCbgZVC81eym93sP980ccmv1zTd5Clj9Z+vEvTLWuJe2i+IYKJ7Zct0rC
 ruiMl+X7yaeYECdlrGmGOd4VP9AJ7ALHW6Un0V9jP9Cgy4SdfnDiVNNJyJQkvxBP1x64=;
Received: from mail-oa1-f44.google.com ([209.85.160.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uP0hp-0003ED-M9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Jun 2025 15:16:06 +0000
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-2e9071e3706so2821635fac.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Jun 2025 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749568555; x=1750173355; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNb4y/YgvMlqcunoawqZQihEjbHUq2NWUz+26/0fBXc=;
 b=G/XJmI3yWBX6Pgk38tto4u+XKqLeMqPmL2E0Zm+piBfXTYd4Kb5PgPlzHjjOjKlexB
 p5K4kgDcPyqqizyy8rXkhPE3XjFnKk4lR0bSQtAnZBbrHpD+49RQnjeX4e6ldEoNs+GZ
 yAX/IxSq4WNaJBwkfAw/Nko0kKoQeL9GCwV7hP7EFfa53YWWMso6Vp/1gC6aKpnGII83
 0etfyfHr1ma1oKzxtPShraLq88PP/aMjnfpa0MOP5lGbntqZCAW5MuyduhtQBN4XJYwE
 dE68IX0TCXkZiiOXaTvx1bTZmzBazjlz+zniIK7tP9BD6fnFDBZepvkM2bW7XcTOJobx
 mbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749568555; x=1750173355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNb4y/YgvMlqcunoawqZQihEjbHUq2NWUz+26/0fBXc=;
 b=pJN8CungzhKaagPrS9bCZmXbmjhNBaGq2SCaLmsogEi7GR+wiwz5fmXVAJ1dRsCnGV
 T2bWgsN+5fxza/NGH2rNpFa3Pozh/xdHS+YRBjaxuKJnJHuq6p6HGyE/PhoLj60CWqGU
 RuRVBxsCz48JPCPQSlDZn2j6BT7CVE0ET37eIIgG/8DJUcUTkxNXZboBUEwueE7IwxcA
 0WBPMRBQA0Bst795WUw8JD/ZRVkMjVDL7GN8KxrwsFbyoShA5KjsdvdNNMPkPJuF9Atp
 aYrB0mGnSbUxEqZflrwYq6FsJ48iKqGIt4aixsupjyI0lpXmdco64qnj7V5FaBc6Xhjl
 gs5A==
X-Gm-Message-State: AOJu0YzXUzcd+ycoSQYvLBUtuJ1vwTR1jX9qtW3usRjqJbCFHiZMPWfr
 pNZBk9kpQ90f7Oy3+sBQYEvweZiegLVPpPFGldYfjwFRULzvQtpxAhrG9VuLyA==
X-Gm-Gg: ASbGncun+DiRvtSH0gtMlrs+PKuAS+0VMcl8rnnKvyiNQbYQbEd2ieiMxUOXUH9XaeH
 WuDlZ5m7V+qtvr11KRi/yPF5VUdueUmSjihS2a8BcR5w75pdAl7MmcngOfsBpeQXLUj7KAK4hZy
 NWHKXh3+pEiOfQB946pcJrjX7eRTxq+/fW8dOFT9xfj9WUePWug5BadUiG5/ZGd1yM2pSUjFkOo
 Vng9cIfYQw9sPUeYQ5iDodCie52zNMgp4OhxOuD7iEJaAkW2yvkFxJLa0stDzt7k1DhkCouhdry
 Oj7XgVFp0LYRAa2QC7/QZ3Uktmk1Ds9siOooHQHaexyT9xz0EQivOOEFAT4konMhoYl8WGsqfLP
 SmGg=
X-Google-Smtp-Source: AGHT+IErSIImf4LQ6olAArrKUvMvoYzs1GnoiajwORi89iZvdAT1QSvuF0yRjvSuDRRy4RFGekCpuA==
X-Received: by 2002:a05:6a21:a616:b0:21f:5532:1e53 with SMTP id
 adf61e73a8af0-21f55321f30mr9385058637.33.1749559093546; 
 Tue, 10 Jun 2025 05:38:13 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847aesm7539815b3a.105.2025.06.10.05.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 05:38:13 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 10 Jun 2025 20:37:16 +0800
Message-ID: <20250610123743.667183-7-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610123743.667183-1-shengyong1@xiaomi.com>
References: <20250610123743.667183-1-shengyong1@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1uP0hp-0003ED-M9
Subject: [f2fs-dev] [RFC PATCH v2 06/32] f2fs-tools: add and export
 lookup_sit_in_journal
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
Cc: shengyong1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Sheng Yong <shengyong1@xiaomi.com>

Add lookup_sit_in_journal() which is similar to lookup_nat_in_journal()
to get the raw sit entry from journal if exist.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fsck/f2fs.h  |  2 ++
 fsck/mount.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index a4888a817284..60e3a2ebb0ee 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -613,6 +613,8 @@ static inline int inline_xattr_size(struct f2fs_inode *inode)
 }
 
 extern int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *ne);
+extern int lookup_sit_in_journal(struct f2fs_sb_info *sbi, unsigned int segno,
+				 struct f2fs_sit_entry *raw_sit);
 #define IS_SUM_NODE_SEG(sum)		(F2FS_SUMMARY_BLOCK_FOOTER(sum)->entry_type == SUM_TYPE_NODE)
 #define IS_SUM_DATA_SEG(sum)		(F2FS_SUMMARY_BLOCK_FOOTER(sum)->entry_type == SUM_TYPE_DATA)
 
diff --git a/fsck/mount.c b/fsck/mount.c
index b1f8e98dd7f0..1f2cc960b9c0 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3290,6 +3290,24 @@ int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
 	return -1;
 }
 
+int lookup_sit_in_journal(struct f2fs_sb_info *sbi, unsigned int segno,
+					struct f2fs_sit_entry *raw_sit)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
+	struct f2fs_journal *journal = F2FS_SUMMARY_BLOCK_JOURNAL(curseg->sum_blk);
+	int i;
+
+	for (i = 0; i < sits_in_cursum(journal); i++) {
+		if (segno_in_journal(journal, i) == segno) {
+			memcpy(raw_sit, &sit_in_journal(journal, i),
+						sizeof(struct f2fs_sit_entry));
+			DBG(3, "==> Found sit [0x%x] in sit cache\n", segno);
+			return i;
+		}
+	}
+	return -1;
+}
+
 void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
