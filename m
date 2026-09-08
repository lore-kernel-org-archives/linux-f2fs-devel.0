Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21495C79F82
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxUYpgbVvVnvJrCHcjR7g0MFw0851iG7e/ijZVndmgI=; b=CNJRCLcNy7rGhrFyVcXlCNGXmb
	T88yNgVw7qsUMfAkhwvd6Jpr3NHQM603U2HG/vHQ+wRX5YPas241rUDQSdlzjMhi7/Durb3VWdJBQ
	OrJTKyWmT0QKvereDcTEz/yGH3elJuYM7X8MslvSxelPbAa0OrOtdrLKFQMHWdyLSLOY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3miO-0000vi-At;
	Tue, 08 Sep 2026 03:41:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3miN-0000vc-8k
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:41:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=THA2lQIDtN1IMSLerCBySjfz7rEAuxrQfCu6ehzIHp8=; b=lOxqglAsB5C2eeqON3RF+CWMG5
 6uyCSwdn+EonuQDaDduVT1Mt13SYQ/4jc6IRSiRc1Iy9RcajTZj0EIP5kCeLs3TLd2ZTIqeEs9VPl
 P7tPeHyLIDwdg8MYSnp/PELIlr9jTvkIVaJgB9uD6q/VmA/jkC4JAUjAn/BDqgMi8Y7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=THA2lQIDtN1IMSLerCBySjfz7rEAuxrQfCu6ehzIHp8=; b=jAABU/yiEmh3fRw5jBNYtEQsik
 HeEHpl6Jcw5061j9w5KM0omvCZqc0KXf+rOmWCL14BSG0IYGhdDf2egtU30ltml7wYVIDJ2Cfzps7
 dJFGPem7aYOF43b9/K+Sryzjf9lIUhgqD5Jti0YGqb+QJxMPltFbGYmFee9azOXXoSNY=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3miJ-0003xi-FI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:41:40 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2dae660f31bso27718665ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 20:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788838894; x=1789443694; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=THA2lQIDtN1IMSLerCBySjfz7rEAuxrQfCu6ehzIHp8=;
 b=DlMKBYArsjpaaZhi1EkpeMi95NtKpT9TIxjWYzuHPFY3gg6/yLLRWeivHhvACdAMc4
 675Qq1nuaV7Mdnadf6Jl7R3q3+v6SyEou8FGhl47MjX2M1/yJlGUEPzBlNmVGi8fC1a0
 4KIAwDWAqxdpH3bhbk5vIWjcRMQbD6rpaTTEnWRLtJ184IFJWBPk9TrmGjBtKa8akOcj
 7v/hB8NgobA84oGLMM/U9RVp8yunVwuTqBAnbFZFKQLQgEpRK8W3MxFeZ3ULAjtWSOxJ
 2PSFAHrDTMdXDGS2ySXYEF99mQCmYqeod4NG8vzWNI6+B6rNvg/t0IZqyvKH/HWSSffx
 ND1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788838894; x=1789443694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=THA2lQIDtN1IMSLerCBySjfz7rEAuxrQfCu6ehzIHp8=;
 b=AE+dg7t3bhYSHh48c/0LzRvU49UlOebgDAFESWSAHfwBZPuONRAu0qdvpJOamsoegI
 9ASRgrmtpvj81hgYBO7tkmhjQkmpO9yMXaY9pNM326AwsR3+1UJe2c269ZuzuokrVOow
 rdD8eRWNw8rfCUNd9jrSAw2njoqSIYMdyjbICwaI3bOYD1b2OHU6kMiYs9HmGdJA9cG1
 N/ViU1tRkUlaL11SDj0HvAEpFG0vxHdnWzw6e2JhVKmGgvSFC/Zhha/qaZbTyixItANX
 aWONw/poPOcYSJznJOwlDYCadkwYDljU+o8fvVtv0N8pIvjhL2BuyeUlpCQWYluh8nCA
 P7dw==
X-Gm-Message-State: AFuF++nKLH4yAO5MDdhyoBQLdbZWNFb8gEd/Wg/p+c/ox4aEMGMhs4mt
 aHHSH5QTmoSRS6P0RSA8MtfM0BFdQV0ABu4pitwwhKclJR1EjhgPJUXr
X-Gm-Gg: AYBFou28w7lQbk2wYV+rdYYmaxK4QT4JYG/j+zIO5VZeGTlNW2MuoJMqgHYRx2qBvtf
 1LgEMI7cd03qg37nKD1GphcP3K8e5n70td6trTrCNBADWLoRARMpazYWg5pOOkuIH68lvY/Dww5
 URjTDBICZuxcPQOXx7KmkQEZ/a/gIs/kAGyZg3ygjNEgdS4DfpaZqJnifccUOzIPELoxYPRxR3c
 /x9dD81XULjiFEKx3yk7JWaOxO6NIXrufbX3+3WEp6ud9lmcoDW+Uviq61c2o6e8D2dyV+h9YVX
 USdKy3RENhGgYfC+sX4tLShn78TEHYf8yAiECHg4uW0YmkKCU2b5/aIqNyrnJb7u/11QZuSjx6r
 a2Wo8HrrJFNNXB0oQiBbxsGjDaqN+q3oRJGY7cuvseaDJ7je+HZmvNzGmkF07ZEvT4fYABlZ4Bk
 TSvbDfYY82eyQaobkQt6s7a8UMGRBkgWS3McpiMR56lc3JfJp+n1jx1a/tDt/PfMdxvgQhPA24E
 bgxFUQSgJdTFT22Ya6/Y3CZ1g==
X-Received: by 2002:a17:903:26cc:b0:2db:56da:6a0b with SMTP id
 d9443c01a7336-2db56da6ebbmr159927625ad.13.1788838893763; 
 Mon, 07 Sep 2026 20:41:33 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db149ccf2esm51691435ad.73.2026.09.07.20.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 20:41:33 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Tue,  8 Sep 2026 11:41:26 +0800
Message-ID: <20260908034126.3251396-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
References: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3miJ-0003xi-FI
Subject: Re: [f2fs-dev] [PATCH 01/14] f2fs: extend folio state for large
 folio write path
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

On Thu, 27 Aug 2026 13:51:06 -0700, Daeho Jeong wrote:
> ...
>> +	ffs = kzalloc(struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
>> +			GFP_NOIO | __GFP_NOFAIL);

I think I can use f2fs_kmalloc() with __GFP_ZERO here, so that I can
exercise the failure path with FAULT_KMALLOC injection during debugging?

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2616,5 +2616,7 @@
-	ffs = kzalloc(struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
-			GFP_NOIO | __GFP_NOFAIL);
+	ffs = f2fs_kmalloc(F2FS_F_SB(folio),
+			struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
+			GFP_NOFS | __GFP_ZERO);
+	if (!ffs)
+		return NULL;

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
