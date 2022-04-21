Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74ABC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 22:19:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhf9M-0008Ba-M2; Thu, 21 Apr 2022 22:19:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1nhf9L-0008AZ-3v
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ccm3V7dSoJaRYt/ucW5U2rWYE8sFYTIWKumrST4/Vds=; b=A9N6lU+NgL3QiSe7NyaAIQyVzj
 wipjDjpfcJop61StepAZt/NUl+8sPAityZf8nKAMpumRM9Vbh3/RulD88QuKXu8CPYHyj2xx8HD5j
 wOY4vT7uOAc/d6PLxRgXTjBvv2XJCDJ9nwjhlTULM5BxqBd1Ka/mfXY3KidKADHKidg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ccm3V7dSoJaRYt/ucW5U2rWYE8sFYTIWKumrST4/Vds=; b=Hh9/7x4MJautUXVTqhfHvNL0dN
 zZW3Vc2oVo6HBBkqlkziXH9+BEG0D5M7F1/H/k0pDwlOXeyiP8hIAf5tYS9hS1FrKElVueMWbAdWs
 Vngx2hlkhbImwgJx/WiwUgto4ukJu88PD196Oi5IBA20Md0q8mw/WEGW7/F6AVVH0ZlE=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhf9J-0002yq-JU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 22:19:42 +0000
Received: by mail-pl1-f180.google.com with SMTP id s17so6762927plg.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 15:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ccm3V7dSoJaRYt/ucW5U2rWYE8sFYTIWKumrST4/Vds=;
 b=zbF73K7eRROwbLygL/f1ZJlTZHqUNct9VAYA7qVFiyeLlOp9mJr4aJHrzh1nMUFI8X
 +sr0eiSw6iXUE2l4/jyGFHVL+FLAxyAk+sVEDzM19+wo7TOTyqZTp7WGSqEsIjFMV1iL
 p57iBpnfgDYMMqHN8bJ7gwRlBh0CucSxjRZ0XHf9KTWD9ukZUXpa36tMYR/1SGdULHbn
 5mqq2fy5TXcxCsDjSorHqNvJQ/DOx+HbiuJJSv4jAdjcRZk3iPR63y4tuuKcrrr6A50r
 jdW2bzpYuaxxGso4/0QRUdSfjAaJhCAKHQ+TVW3gne1jzO9k/Jl4DXF3YMGTCttcR8TZ
 7q1Q==
X-Gm-Message-State: AOAM531Y9JtXohJ8XT8BrtJYtg0uS0Ih/s2rQr6uXUry1LZadd0OJzhG
 8Ryhe7BzXGhyUSc9pqHr8ls=
X-Google-Smtp-Source: ABdhPJyVB/F90+x/oe9nAZifQkkgs+ztT1TwZlvmjot7onQEyquaGIaqP4UokheSdqsvZOrB1FSGug==
X-Received: by 2002:a17:90b:3b4b:b0:1d2:e3fe:e1a0 with SMTP id
 ot11-20020a17090b3b4b00b001d2e3fee1a0mr1924836pjb.78.1650579576013; 
 Thu, 21 Apr 2022 15:19:36 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:a034:31d8:ca4e:1f35])
 by smtp.gmail.com with ESMTPSA id
 hi21-20020a17090b30d500b001cd4989ff4csm3794876pjb.19.2022.04.21.15.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 15:19:35 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 21 Apr 2022 15:18:36 -0700
Message-Id: <20220421221836.3935616-32-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220421221836.3935616-1-bvanassche@acm.org>
References: <20220421221836.3935616-1-bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1nhf9J-0002yq-JU
Subject: [f2fs-dev] [PATCH 31/31] ci: Enable -Wall, -Wextra and -Werror
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Make the Github continuous integration checks more strict.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 .github/workflows/ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 0c774f92fac8..428039db860d 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -66,5 +66,5 @@ jobs:
           ./autogen.sh
           ./configure --host=${{matrix.host}} \
               CC=${{ matrix.host && format('{0}-{1}', matrix.host, matrix.cc) || matrix.cc }} \
-              CFLAGS="${{matrix.cflags}}"
+              CFLAGS="-Wall -Wextra -Werror -Wno-sign-compare -Wno-unused-function -Wno-unused-parameter ${{matrix.cflags}}"
           make -j$(nproc)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
