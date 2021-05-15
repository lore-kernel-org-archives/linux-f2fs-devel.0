Return-Path: <SRS0=dRGj=KK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB13C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 May 2021 18:10:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535B761369
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 May 2021 18:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535B761369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lhyjq-0003N0-Su; Sat, 15 May 2021 18:10:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <trix@redhat.com>) id 1lhyjl-0003Ma-6M
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 May 2021 18:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a37RUy38tpQv2jdd94Qqtdr4uSz+DEetL1oJyyI6Pv8=; b=QsQFTEStMrRTTOStk7U6BKm3QZ
 +8umeKhtf6AKP9aohHWfJSWMZxp6dWNSFPXb88J9tGOXtYYV6B3i/XoiP7ODYGFw93eh4AKN5AyuA
 By3eMfqERlESGlu3xRwysFi+eRuc+SocNJPN76AiEkb5I+Hn30xZUEl6jLzwQszhiOIQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=a37RUy38tpQv2jdd94Qqtdr4uSz+DEetL1oJyyI6Pv8=; b=H
 846lUssShuXnJPHETDyPs8OAS9dMuZuYxzW2E3GEU3fuFb2MU270o7/zLtgRZlW0terbdVa2w60t4
 XBVaF8nNKskx0mf32zjPI7GjutPX/oa4AtK7cjGjP1nvuPYmCgzKh8HNaAK3PPj/1j2IiI/URDjbb
 YsBBaaIyA+iMFu+U=;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lhyjZ-0008IE-Kf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 15 May 2021 18:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621102188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a37RUy38tpQv2jdd94Qqtdr4uSz+DEetL1oJyyI6Pv8=;
 b=Q2QSO5PfFKcF9WZppgZcfAO0bk/EPw3W/hpUZxU3PQaAuKLldQCBLmQVLwsvFdz7kNjNuq
 NqMqCTPM9T3FUd+89kzREVu4HJ9TrLh727QNPcrwVJOoaqSad8LmM8XXRauqubrmMsRdzo
 LtkhmgTbhmwCC7TX3RzYvO845/QA85w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-lYv5KCR8NdCAENeedzhIQQ-1; Sat, 15 May 2021 14:09:46 -0400
X-MC-Unique: lYv5KCR8NdCAENeedzhIQQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 g184-20020a3784c10000b02902e385de9adaso1734895qkd.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 May 2021 11:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a37RUy38tpQv2jdd94Qqtdr4uSz+DEetL1oJyyI6Pv8=;
 b=A8K1MkBrZ4qD9otwUVg6wBv2FVTU7lcxltiIlSWhNjeluGQVhrCg13gTavtc7xb4+e
 7SzOSYfJAcwm4xMNFG2Imuh3zC2OSinkIVItMWSv/JG3yHijNc6rb3mxdzhkBYVJjeXd
 UEJo4u5/rlMTs6lbhml+1CwRr0BipRfysnkOUHvdb166fm/hpZrSCSgJYogtZV5AYKvO
 qdiNL8dbi6649Ma+YEXGGHy9lb3GJch4w/IBcLldSj3YrHkvx1BgVqE5Dg19H2CII5qM
 ehaPyTBv+YAuqlelMW9N+nkYnKRIjbD+ygkjVjFoI7Qx7qA+7NLngvoq5zPpYQj5FPAL
 2/Ag==
X-Gm-Message-State: AOAM533wXglig1khOQCdsKK81WbegdrsO9XCYMtwaf+rCvC7oUH1mMN6
 zpVyj7Pi40FDC3VB3MWXHxjOH6IkZBN+E0RObPu38JcBN1GOeCkoKgOhLwesbmn60OSAF58vFog
 YSJCDW9/pdV+mg7c+QA0SNojJiCvxjpgX9fadpw==
X-Received: by 2002:a37:ef17:: with SMTP id j23mr45225798qkk.392.1621102186130; 
 Sat, 15 May 2021 11:09:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyla+8xaDzC7jNYp70uepVTByVn5MkwxjTVfLndkNLD1XSNnPErIdMTtTRqpHXJ4FywHUjblA==
X-Received: by 2002:a37:ef17:: with SMTP id j23mr45225775qkk.392.1621102185693; 
 Sat, 15 May 2021 11:09:45 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id p10sm7077984qkg.74.2021.05.15.11.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 May 2021 11:09:45 -0700 (PDT)
From: trix@redhat.com
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 15 May 2021 11:09:41 -0700
Message-Id: <20210515180941.1751362-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Headers-End: 1lhyjZ-0008IE-Kf
Subject: [f2fs-dev] [PATCH] f2fs: return success if there is no work to do
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
Cc: Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
file.c:3206:2: warning: Undefined or garbage value returned to caller
        return err;
        ^~~~~~~~~~

err is only set if there is some work to do.  Because the loop returns
immediately on an error, if all the work was done, a 0 would be returned.
Instead of checking the unlikely case that there was no work to do,
change the return of err to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ceb575f99048c..bae0f910f5f0a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3203,7 +3203,7 @@ int f2fs_precache_extents(struct inode *inode)
 		map.m_lblk = m_next_extent;
 	}
 
-	return err;
+	return 0;
 }
 
 static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
-- 
2.26.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
