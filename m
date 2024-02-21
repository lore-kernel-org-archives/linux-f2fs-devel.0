Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6E0C48BF6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:14:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rchka-00007K-Jg;
	Wed, 21 Feb 2024 08:14:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1rchkZ-00007D-28
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 08:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLLstCGYI81xQhpwq9Yxp4yDZIlsvXljT4KfVN7Dg6s=; b=HdYtMSdExPrRICp6J3YAcApm6B
 BTMbWAINudbxnqcP3dCZ03VA954SVAHGBn8pogPqsVYy7YaiLSGIBqryjVKzrrJROywtqSjXt4gZ8
 071iMelar6O9odH3zsfs2Mbg5tOxzlxHddTveASTUFLE6/hOrcT5ecX0JUpiG6qB14ww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RLLstCGYI81xQhpwq9Yxp4yDZIlsvXljT4KfVN7Dg6s=; b=B
 Pjmtmx1wbuxu/t4aRELK7EZBR7obu20YwzHz0+BUqpLJ0JiRFHLlo9JagqDnjmAmIRvkfbeO2luTc
 n/Vx9XSCNspNAtp4mlVx4BQpuqI9iLJn/l+6aOqhlHRqlGyhmJ4kqQni2UZrdi+5AtqIn20zc8gcy
 i6PyQMykbzTRInn4=;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rchkX-0004KL-OZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 08:14:43 +0000
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso32260075ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Feb 2024 00:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708503272; x=1709108072; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RLLstCGYI81xQhpwq9Yxp4yDZIlsvXljT4KfVN7Dg6s=;
 b=DCgiNSJSfU/6J3m6X1169R8qaJiVWym6Ng2sO2jCyCDWT6fBoGWi36DIXqMjMsFCNV
 jT4CKKQnDQkg5/3uBYFoe8hlKxtN3q2M57v3JpV/FEoR9eENonQTroh6p4fvNVcmOeY7
 /hcfnqCmhQ/Ow4/zvuB5yHxrumEM++4PGuo+VXs12gN5ilVp1IpOt0QPq9aydGVhsF7Y
 EEAa8ha28fCgjtQ3+Zgy2PITgw82wpgUlsHcf4wbztVLRURy4VI4yEmmxGT4vTWL7/So
 3Utzur+kxjfWVNvYmvGtpWnBAxMHg9bxt/G/zseZoI06xPUyKrhRAPfFKW24SrXQZgW1
 vQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708503272; x=1709108072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RLLstCGYI81xQhpwq9Yxp4yDZIlsvXljT4KfVN7Dg6s=;
 b=PC125XaOVCgZPB7jvb6c0WemvndEvCuG53ywlw/tGxl1QSoSukCCB0EoMUqKAeU5G+
 +e6rQvViTo991+ERs/8QB3RwHqAp+NS51lOEIRNAdZ1C7EYGFp5NhtKat9N92zN4EVCb
 jClXGwS5CRtzyiczDIjg9dDsYb93kZaOa396cv35nfbERz7lQjueFEHReWvm+W6IUdVT
 WiVxNOcN17cUsU4lHusRNtXyp+Cnz868WYP+lxJwAQ8uOWCoHipdsJCY7TlAs5tgpoVv
 BOv2JFzCKxRwTJcb583IGJmMAL1mP5vujLee/ELOVfvCZREVkgcSArdEZy4BwxqR+wR+
 bzNA==
X-Gm-Message-State: AOJu0YyFs9jHCbPt/3FVdW3gXXuxUjGYohXsxwdk6+QkmtDF/i/e3HbC
 SDbDkugSLjrjfnE90H/6+ti5cpcSSi9ERM/CDE32y7Tmu9liwsxA
X-Google-Smtp-Source: AGHT+IE84X1gwtq0IISwa/yDBtGDeQ/oOnbumLEt9s6m0b2yQuk5GOnSCx8Fwx3Hj//33cWNcZLtVg==
X-Received: by 2002:a17:902:c084:b0:1dc:20f2:77bb with SMTP id
 j4-20020a170902c08400b001dc20f277bbmr2597073pld.29.1708503272399; 
 Wed, 21 Feb 2024 00:14:32 -0800 (PST)
Received: from mi.mioffice.cn ([43.224.245.229])
 by smtp.gmail.com with ESMTPSA id
 kr6-20020a170903080600b001da1fae8a73sm697162plb.12.2024.02.21.00.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 00:14:32 -0800 (PST)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Date: Wed, 21 Feb 2024 16:14:20 +0800
Message-Id: <20240221081420.1712430-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1rchkX-0004KL-OZ
Subject: [f2fs-dev] [PATCH] f2fs: control gc_thread_func to run periodically
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
Cc: liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

By default, the gc_thread_func function fluctuates within
the range of min_sleep_time to max_sleep_time, and only
when gc_mode is GC_URGENT_HIGH, wait_ms can be specified
as urgent_sleep_time.For other algorithms, we may also want
to execute it periodically. After introducing this patch,
we can control the gc_thread_func function to run periodically
by setting the values of min_sleep_time and max_sleep_time to
be the same.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 fs/f2fs/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f550cdeaa663..df94e64533de 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -120,6 +120,10 @@ static int gc_thread_func(void *data)
 			decrease_sleep_time(gc_th, &wait_ms);
 		else
 			increase_sleep_time(gc_th, &wait_ms);
+
+		if (gc_th->min_sleep_time == gc_th->max_sleep_time)
+			wait_ms = gc_th->min_sleep_time;
+
 do_gc:
 		stat_inc_gc_call_count(sbi, foreground ?
 					FOREGROUND : BACKGROUND);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
