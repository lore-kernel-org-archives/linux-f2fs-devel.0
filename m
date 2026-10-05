Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28846CA5FF5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qO2qPB0V7HfPllOxKqy54zsTbmkhioxbSsnhVK7VTWI=; b=CqWvLQSc8JquaCjWmC0r5pKFRY
	y7PnUVlJiwm9epR4+qU5MWjm+mchw9CppD/ecWS6ZfBCNHeVLOX+KvPZj5lhH0RUHkq+dvEIwltwU
	mjMonKALQY8H9yBubVrxLp1EYWYfhJD/L0bI9hBkt93hZ+QBzfLSuGMvGPXYLS4UJsp0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDp6l-0002nQ-7g;
	Mon, 05 Oct 2026 20:16:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1xDp6k-0002nF-AQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 20:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A03NCvNhh3WeozLGLnn96zZOJNDuJhAaaIYn6yhKNOw=; b=LS4lDM0K/Ch5RKC8QT6XcfgRI1
 XqKjqeSF106DNjUpdGMjiHFx1XpEbWVltAfWv6XrcPLuifiD2UU0aaPIVnNRvbVaDk3ry4usv7GpF
 kevzadm86x0Pqhl9ShHn6Wy94+EeIeKokVPuhP6F8qtVNN95ofPZ/OgJOCmDyEXg4DfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A03NCvNhh3WeozLGLnn96zZOJNDuJhAaaIYn6yhKNOw=; b=A8SJ8sA/0losoV/SQuX93HD1Y4
 ZCUFg0jKo31Gvhmt72Jiuga5Xf+cPEHqNhrEy7+VnGkrpBiJizrixkQ/xX/cNA4E6trosH3BbYUza
 nQQNg2qtaTuflbC5dF+WOR56RzIDQGJb8zCVtNsP01fs6ToEeE49tzK8dzyKZr/Heibk=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDp6k-0000QH-P5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 20:16:23 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3a0a911e8d6so1027782a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791231377; x=1791836177; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A03NCvNhh3WeozLGLnn96zZOJNDuJhAaaIYn6yhKNOw=;
 b=qPZu3gk3paReyOMJGqSIRRifdkAiFN1RnvDJLJQnhMztKTst/bZksRniVyM85mk2tx
 FPIwRQwJDUivszT0OggeJ7NciOlwMXv6YDIOlhEPZ9u2MwFvh1mdmL/yWyZERKye8paB
 R7R70L4pZWq8fvkntSuOstk7es5ZB0a8D1kOli8sRWHf8H+SC9Dj5rHERz6I9k8Vm+fW
 57vMKrycYs7pl7WIAcJC6bCnyiG1NMECBgoPywkSrpzNfdSWvWWJA+aBJ1mUdBlgvzCx
 ZOpSSpH48YZatURqE2IW66vagqlQyW9u9f5bXOJVHBd0apdO4vp6pBq16+DRllkk5vOu
 b/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231377; x=1791836177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A03NCvNhh3WeozLGLnn96zZOJNDuJhAaaIYn6yhKNOw=;
 b=qr2rg9xvZNTSiTEb8eT8mZPdFq8cl4zn3OR2roeJKsD3t2EPYhwiSEkGMCpGNvh6xs
 pvYzZ4J8EGzk/8UYZ0TtokOVc/dx4im/5hOqeq4EG82VmcYIee/EGrBRsoSBdJETfo1F
 mc2QIuYwmQ3OqQox8ZK4GYKiirCuIFN+zCDWRO6nV0NJjzWbxMBY2zHoJsjejqJ6b7t/
 68X/wwEZRhYUASrmTYjd+ongQz+IUmEaQqN7qKKLpPZaFACYbD4+ah94CpRkePh8RIj9
 NVvn6YAagr1r4nLJ4yyWc6ycVhd15hQmgkNcIS/THgkwgGxKdKz2dwN8SzDHaP6qZdJp
 cKJw==
X-Gm-Message-State: AFq9FYLlUBCJopPR1BwN5V2wCaRI3P+UmQCb5TY1zaJ2wVW9OW9Vw2Kn
 BGOsG3eI0lwXAWoph0u9YrASASesM7st/bq466EMQGAj1tw5VmRqcYMLWzBCYLae
X-Gm-Gg: AYBFou1dIe1q/gnFsE2FtPhLmXuD8iwhPcyvO6bFiwQR+foF3bsanH8CcqiUN6LXCHC
 NEQE0g2aBTwj7KqltM6XWoljrYocwW0Mqflhf+dUGErFhjKN8upZoqCM4L16/Mv+ot0Gt8vr3Bd
 7e/il/Uf39+68qOvayB0EJWFlnp/4ut22++VeImcg5cFTfjfEOUbGLhaSktENF5mWD1GW/0dAfH
 b9Q8KzCCQdtEbhQIMuU08lX8jUVEqBcHay53w+4SuG4+NtKpP96d3dwTQ2ej729YAddFg8lh8PI
 bsaaP9zs8eGgKd3iwmSGdZRlqk/Hqz+uZbm8yuDCs0P1wpyIrNQMbb/Css0YTvKy+L3NGuAtUl6
 WpyIN1qAArubprSVoAX8MbivDPNP/7fzUnZwMBTuO24XCHe1CanwV3ZRB5Lgp0cpRysReB1m2t9
 J6kcDRf77rebD3zKu/8IGKrcwnViD2SWuopjizsPbR2uP32t1bSHrKdcismP1SpOZkjOWiBGnPk
 zIrIDASFyM6Ix0vqnpPGt0I45UAa4bM3B6eskjttIg4UrGpwh2NBfKapSXSoH7uqztZ0SUuu3Qq
 9q67PlpDBYb/GfMU8T/nyXvFlaeDa5C30Qt/NRkFMLqnRwwfHtpS8fiYS+/nJsecQyWWRo4S8eY
 BNA7vFCFe424INnBakvIDc+gpggrJWvDtcRSSzR3HMTBrwey8773I7A==
X-Received: by 2002:a17:90b:544b:b0:3a0:cb48:df6b with SMTP id
 98e67ed59e1d1-3a7873db380mr7016691a91.34.1791231376833; 
 Mon, 05 Oct 2026 13:16:16 -0700 (PDT)
Received: from arter97-x1 ([58.124.177.116]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a854257d18sm1149443a91.7.2026.10.05.13.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:16:16 -0700 (PDT)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  6 Oct 2026 05:16:05 +0900
Message-ID: <20261005201605.693574-2-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005201605.693574-1-qkrwngud825@gmail.com>
References: <20261005201605.693574-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xDp6k-0000QH-P5
Subject: [f2fs-dev] [PATCH 2/2] f2fs-tools: remove LZ4_MEMORY_USAGE
 definition
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

liblz4 defines this from r118's commit back in 2014.

Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 fsck/compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fsck/compress.c b/fsck/compress.c
index 5314b6b52034..6fe3cfe6177a 100644
--- a/fsck/compress.c
+++ b/fsck/compress.c
@@ -30,7 +30,6 @@
 #define LZO_WORK_SIZE			ALIGN_UP(LZO1X_1_15_MEM_COMPRESS, 8)
 #endif
 #ifdef HAVE_LIBLZ4
-#define LZ4_MEMORY_USAGE		14
 #define LZ4_MAX_INPUT_SIZE		0x7E000000 /* 2 113 929 216 bytes */
 #define LZ4_MEM_COMPRESS		sizeof(LZ4_stream_t)
 #define LZ4_ACCELERATION_DEFAULT	1
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
