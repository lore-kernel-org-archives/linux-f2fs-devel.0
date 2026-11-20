Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5C606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cD+iTviW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hYGmjaWf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OZLv8TAv;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=acuSBleh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=CkoxxBWExuGlQii9lM17AbOQWHEESk/8bokHl/9UJLE=; b=cD+iTviWzPhzv750bRhGC8JR9u
	0yRN1Q1pWkvGKE0Nd8MlQtXbJz0OmrR5rVTGrL8OsaA8L5CjSkl7G9RevKq1iduu5HS0ici1zYee5
	/xMW1/8Y0Qr8/X2yv7puKtjAJ/WwaUdMoQCq+2WowicnCdrWTErRQDY/Iw2WoSKfbK+k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUKlK-000000007lF-3ecW;
	Fri, 20 Nov 2026 09:18:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xUKlK-000000007l9-0h1p
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 09:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LKNcUjiPdctgglYR7W2eprVTeGLfvr9jOphlzyK9oG4=; b=hYGmjaWfJ6PIoxrTg3T2GL51wA
 PbQlUiIYOS9FSzNkrpIQZ5nHrGEAc75EOdBnNhW3FLLMCsTYN9C5yec2Kt+lnRINBhGSuCoetJENT
 rKYTu7ZAuGzZUEhvGsHNVwymK1shke2Npw51oRJamNJ0aPW5iv44ommJ2cgEGARu8xeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LKNcUjiPdctgglYR7W2eprVTeGLfvr9jOphlzyK9oG4=; b=OZLv8TAvxlnDh4kD9K93AgD5fq
 ZZfk2joeS3SscVWI1Ikz3l8okhKiwSFSJJzx2u5EB2qzpOisOukVO2N7w7ctCHKe8w2Dz/FauN0pw
 sdUNHTpFrx071l24twbyIuUvJ83d6RzCt0Sv0PuYcF7Hd1GSu9DJgqWAnopbMzOi2xA0=;
Received: from mail-lr2-f10.google.com ([74.125.230.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUKlI-000000002r0-3Xyk
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 09:18:30 +0000
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3acff0d1090so1383321fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 01:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795166302; cv=none;
 d=google.com; s=arc-20260327;
 b=JypD0ipLPl8dsegJkW6osUurMjaMC+1d29TLJvIlP0Z6aAWZQ6LX+/gNxzt0CeLda4
 Ba4yqH6KQliNFtHCzZmq1E6qzr2okszJ3IHwMXGgMMiD8/lw3qJn6VzRdnczaxwNMnMR
 eTr5XPz5HMPZ38s4R5+5M9/512cfjxuXNZbbcaifRmpxqpuRp0I7Hoyj0QNOtJoxPK6a
 x4HdXJLZp0dVaOpL1Mg9B1ymDmf3Jbz+fdwEnn/WCrVFN62OivuqZzoxS3/udQOqeGVX
 rQ2jzpAKo3Ph04jGYTUbGjCoS4BRLxcD6mVDlgIiv6j9pI+0+nWVtYYnyBe6qYxTu0Lo
 z+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LKNcUjiPdctgglYR7W2eprVTeGLfvr9jOphlzyK9oG4=;
 fh=7eVQIfOQgSi2k0jNbntgatHnLhsBsYFOniaLVXXeadQ=;
 b=mrfFTTtrdgly8tjUs7DIcN8b3hdn0+LC2TyqVksP7AD3PJjgvK4WNVXmhfr/u9puZw
 w4jtF7bw3AmnDUTvhD54Q2o9BECABh0eoK6iMwNG6N61FuUATdkmS3tbMpLI/T/ikrlp
 8m5wj3kLfkVAXypvSbnnD2CF3rHE6cOOOvk9NZT0uxl73e/lb9joBbtWn5C778dDB/Qu
 4zSlns8IM3V6GUrvNb4rElOR/TzxKX07QQB2R3DHYCFxnXfHtmJ5zhNXv3WJgVP5AcdF
 0dWem9gWCaJCaxWe9KZxnJQHoouIYwD2qce/AdZ2qBtOFbYVMRUhdAv0KvWgFLmqwpAp
 t/eQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795166302; x=1795771102; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LKNcUjiPdctgglYR7W2eprVTeGLfvr9jOphlzyK9oG4=;
 b=acuSBlehqmG3fOfbOXCC5euA9MJQRK0VUnF7Nxck+oXwJ2q9blmK0atiY2jutB5HRO
 jMMdctUL641Jhz/0gKYJTZTddMd0m34lOmyRmI9O+b4KbrlQ8wIh5rUxNCgnzdlFTntx
 Vv38Ce9kl8J5RD0DXU34OizWY0q9N/q4X+eeiJw/WIhXhEB68pJNbrX9tTuvjLUwLzQJ
 H2TNGfp/p3lAYvZMm//7+GyvYRS3/ogiFelgR52+A1WcTSErJe32S2v5NWN87hlhyVQ3
 NFX+rtvbSeV8u33K2OgJ5Wvm9ziULPsuh7V8UKwFCyNNbKmrn3St4sQwM8pHdLVfoz+P
 5vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795166302; x=1795771102;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LKNcUjiPdctgglYR7W2eprVTeGLfvr9jOphlzyK9oG4=;
 b=XgasrILWF6ijTaEEcBWxZgm8gsC6JZT4GBcNH96kcmnS2Ao17BVKcdqJ8754skX/JG
 b2ju6YOv8ZFL5Tv2jg4hO6Slnpi4KWSgeeIIWQBMz5IVrpEkAdlBU0CbbQDOZN4d3Xfi
 Lr2zrKa/Ybrpn+qOV42Pnnq/aDmYLM4M4dKXph15HxZZ3eNr6J+CHsfCXgtX/NDRr9T1
 sDoXYkQ0AiaXoB/FkHzscHx1ZUyZz7cGiHCdHAeXTxooQT5jUdToudYnLww1mmOIUwIa
 OlFM2LbpU8SSj2rVr+k3X7/6gbe4zoXC1rmhheWwAnSk26uO99EP/jzQFi4FAW4snCKb
 z12w==
X-Forwarded-Encrypted: i=1;
 AL+hErGwOYtGLfnFSWxvlvS2LKiL6hBkwb2ziMIyJ7NjAZDFWAlcaaVg6dpnWkRwYfBNAty9XZh9UxwPAa+bjROdr4Tx@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/fMo+Ghk8qye3sZY0Io/57yrtYLt9pYC0NPiKP2HBuM6diKp46
 hbrkEbGWr62/FjoBX2Kdj9woysQZqWT6idit1ZkXItJ75U2VaSH4hfRMV7/AXuHvMGQrZ0BFeW+
 k1gTZCraP4Cngjqa/89/5VDM8m+Kgjro=
X-Gm-Gg: AZFdTZfEYCeXCAnw/ARsI6v80/63k8sAk5KMfmhWz5jM7ZX3xVwy0PhUSoy1y0C9FyW
 hSe7tQyRjDV6IvC5eJHM/ys3a4bQghdXraH6G55ppx9ZPvl4/KxQezi5G7UZfK+YodBrB0GnooD
 GyalkgyF24zKxCA903PDXgR8KpUWB+nU3gp7n3XXbj6X3xvHkQMOVlng4eqOElWwldda8BVjOMj
 tW1xAhZtirBIlgGy4CwiUHFFsrPsFxDMfqqc09jBOs+3djMD1XZkrKGZE36P9JiRtZT0tnMkJFT
 kWA5ed6HQe7sV6jj25oXd6vAqBIgb94cPNdYpFWDV9oJXMEJ6PqUjRCJUizJ1QvyfFiOCy5Mnyl
 0Ku4YxfQM1Xn7TloIskbfDYhZr/mV8ol7abTnfUYZjrsU61AH3STD9pYgQpAf4NkF+uPxBDFlLI
 f3Fqk5DjPlGzndC14903Cl6xljTydstMhzvDMvFtzZtrbchSaInczE
X-Received: by 2002:a05:6512:3503:b0:5c0:a65:4e79 with SMTP id
 2adb3069b0e04-5c1bc84aba5mr734450e87.41.1795166301858; Fri, 20 Nov 2026
 01:18:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112214303.16198-1-dennylin0707@gmail.com>
In-Reply-To: <20261112214303.16198-1-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 20 Nov 2026 01:18:06 -0800
X-Gm-Features: Aa3M54oQtZ0qOiM5E-eLggRfvzG84Hvr9XCvrCFnTpiJPy9BPjxn70QmsI8m6Zw
Message-ID: <CAGEkeHe7Vsqrze1oxA-L0urvOwAx0w-FVsAJ__LMRBJbujwmSQ@mail.gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xUKlI-000000002r0-3Xyk
Subject: Re: [f2fs-dev] [PATCH v2 0/4] f2fs: require write permission for
 ioctls that change per-file state
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chao, Jaegeuk,

Gentle ping on this series.

Thanks,
Hungyu


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
