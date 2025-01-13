Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C8FE7719E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jan 2025 03:05:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tXAm0-00018r-VQ;
	Mon, 13 Jan 2025 03:05:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zangyangyang66@gmail.com>) id 1tXAm0-00018k-7D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 03:05:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iqz4jsczr3ZzPgEqpf2uEBMfgS04X+9fDy18EzG1M44=; b=bcT9OMt1lXwYdz3k/rXjMhPKWQ
 RGnDpf8ubudkW01mYFOIWfbqaipuY+wzYrIG8z+FbPVaALpII4zixJ3bEhL4b5lUmT3o5jkR3w515
 WxLucEgnFLgdai+jxMh3nb7U9xdQnQ4pKZhDIstlZnIqpw1j+v38TzuxuQ1PqKQA91Bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Iqz4jsczr3ZzPgEqpf2uEBMfgS04X+9fDy18EzG1M44=; b=P
 H3337gtSHO4DDqwfliJ3+PCnhXQkQDyvq0n9EG4KixohGFamuDXsZozZa5JRIg0iNAj1SZzBO7fm5
 nOG4pWj2KDyLJb59/XE59cO78lTxAOfXUlwEzHXzeg77HPbR34dkIqP7y3/PmxN5YeTDEX+khcyav
 hizw0K/N/MtqcvbQ=;
Received: from mail-qt1-f170.google.com ([209.85.160.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tXAlz-0005XI-JO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 03:05:52 +0000
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-467bc28277eso33463021cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 12 Jan 2025 19:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736737541; x=1737342341; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Iqz4jsczr3ZzPgEqpf2uEBMfgS04X+9fDy18EzG1M44=;
 b=WuIpKA7xJMF8U3adRQrHcfvLAAD2+2WYt1BocektlFwoVde15Uq4mAgJzJ8rzgRx/e
 yBuJxU2hS82G81Y+IKdGiZu3hf26ludEw9Yb9usPmsaCRa9rcXc2OTFVFM08wYd47/SY
 8tfund1rpprcEtBaecpzkfdJJiwPB+SUiwDSsMdwbKx2UBEurFE+l9qUItZftuaQJpUY
 WqPLLoEvtsjtqtLAFaToenBFOGY/xeqWcAIM0xO7f4fTwhz9aS+HaWM68oqN5pwTQurH
 2gOa4UQQrvqy6Et6JgCDPR62EnPxd6vkxezqEihhqeecZzh0rNbzftILP68Z887syYPX
 KY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736737541; x=1737342341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iqz4jsczr3ZzPgEqpf2uEBMfgS04X+9fDy18EzG1M44=;
 b=HhmOLbvsCWz+a/pRoSGhBA3vx619E4c1Ax8iORSFjURyzD02bm300JmmpUR5/gGUla
 n38BvSo4dQLvltE9weBgNSredI8glaEVv3suFBGVPxc1mUM63TVb7pVVuo3TIsBNPSGJ
 wLe+zwNkr+ITan7ZP9rK0UmRHEulL6Gxijjd9EG/WF3tW3zqY0ZkexcridR4Da4uGKP1
 wc3Ry168wv/tZMPRkv66JTKwHRt8rgTPzbP+yJ80TedlhWNB2858Ttm9NZ3fs5s6ALif
 bx8tXy83eg5u/BkyhXQHQFsDq9QFK+zHQ5bnms8GYb+ZT+VcPfdwg+9W4QnCsTtPmZgA
 +4ng==
X-Gm-Message-State: AOJu0YwtV2xbED4svcGeyjdTV4QEe80M+30W89A75Ck3v3JeWxuY9UG3
 ADGekLWNYl8vl1VGk5g7hWCw8hcGcL059hTHdO1wesY7CAc2cmjj
X-Gm-Gg: ASbGncup8kkATsn+czzLUP0ZfUKrQs/ZUQW8uZLbK4cy7snGqarIBzR6vaLlgDZB8lK
 Y7xZ43e+6bXSkgXgvK0P7HPvcltZ55Kj2itgqfQ/89P/X2QdCDGlvrzy1V7xF3w3Xfaurm4QeQC
 Ye/3ESG+gRcMD9aIDejFdNwd2KiR6+ifbwIVlpDmsNuxNwEkwm6pQr3LHdsU5tnxT1alk4RR62v
 m5at/VSDnuFN1aJB8I6tuNuLZqpxFvGU2XJ2qt594hnbpmmsfzwsFFGDz2Wb91o5ts=
X-Google-Smtp-Source: AGHT+IFoUvl20HmE0dAntpKNa1/4czC84gQrpxyCvWBMPwfU0O7SzhK5FXA+/9eRa4jLG0pSMcUPHg==
X-Received: by 2002:ac8:7f84:0:b0:467:613d:9a1 with SMTP id
 d75a77b69052e-46c710a0a81mr246536691cf.48.1736737540617; 
 Sun, 12 Jan 2025 19:05:40 -0800 (PST)
Received: from zyy.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe28:43a8])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade72a6asm36293296d6.71.2025.01.12.19.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 19:05:40 -0800 (PST)
From: YangYang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: YangYang Zang <zangyangyang1@xiaomi.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Date: Mon, 13 Jan 2025 11:05:18 +0800
Message-ID: <20250113030518.3639169-1-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Headers-End: 1tXAlz-0005XI-JO
Subject: [f2fs-dev] [PATCH v4] f2fs: fix using wrong 'submitted' value in
 f2fs_write_cache_pages
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
Cc: zangyangyang1 <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: zangyangyang1 <zangyangyang1@xiaomi.com>

When f2fs_write_single_data_page fails, f2fs_write_cache_pages
will use the last 'submitted' value incorrectly, which will cause
'nwritten' and 'wbc->nr_to_write' calculation errors

Signed-off-by: zangyangyang1 <zangyangyang1@xiaomi.com>
---
v4: The Callers initializes it
v3: No logical changes, just format patch
v2: Initialize "submitted" in f2fs_write_single_data_page()
---
 fs/f2fs/compress.c | 1 +
 fs/f2fs/data.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c5e42eec8ac9..985690d81a82 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1551,6 +1551,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
+		submitted = 0;
 		ret = f2fs_write_single_data_page(page_folio(cc->rpages[i]),
 						&submitted,
 						NULL, NULL, wbc, io_type,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f681742ebecb..008ecd8fd386 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3150,6 +3150,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 #endif
+			submitted = 0;
 			ret = f2fs_write_single_data_page(folio,
 					&submitted, &bio, &last_block,
 					wbc, io_type, 0, true);
-- 
2.43.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
