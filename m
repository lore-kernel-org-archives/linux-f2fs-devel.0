Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDCC624D5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6KjW6iH/tELqdJGcSmU7MiS5lIAud6mXullYDjs8AhE=; b=Y+rQ6ezQw6KDy4gPDKmMxx91oI
	o9HclvfJ/L4opvOyPi9/AWJ5Tzd2wv8TsF5GHBEBOCkKnh0t+71pSWB5CMillLXLigPbzpwGXnwxw
	ObYoFK60nczU7wjYC0/TjuWqp1ZE923VmSJZb8j0cgIOW5nMbn9/xS3LPY6J7R6cW8cU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RVD-00037l-Jf;
	Tue, 01 Sep 2026 16:38:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RVB-00037V-Nx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TWVBhHy0WPw0GotWHFiTstZdugISF/16D3zScGhJWms=; b=WQ9gJQfAaIElbHWQu7AsDXeWPE
 aUUnOHlJ25ZsXoplJoH8RZsYh8eH6hVKT2KrVm0tMfHVqpIkbTfRj6DFjl7i3jav2ksnd78KIdM2T
 Ho3QjXGB+ef8odRKo67yuIdBfwoR8GdY+VIWH01cugwI+3hA8a81HM1Tnfc8hYfniOaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TWVBhHy0WPw0GotWHFiTstZdugISF/16D3zScGhJWms=; b=l85NfJQb/eikrHTiuaAzcQKXoI
 8Fm+pp4QcTJHpnT64hZTL4Sy8cLVKvhX/m0nPEir8FF1sDg6wxOre2DJHMIMqpPKbL9uA6bPF+P6W
 0JQdEuUibg7QPQxBb/pGWphMJOva67YDQIfw3CSqAX4paSADfzh4KEcE0l3KXv1SsvcQ=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RVC-0007Lj-39 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:26 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a60d406a5cso65223a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280699; cv=none;
 d=google.com; s=arc-20260327;
 b=DmsfTqzjB6jrijeDnsNKCdfNUK9QuYH6LR1eC9UphFi/vCjIZYjwHC+iMGZpMiiWPV
 8YpwcDY2Z+Hb524acIOJUjQgRQbJG1zpUe7kEi/4BYl0iRIfeI6glI+di74TuIlFATKu
 xGheIVw0dB4nGQbnSR9UUvK52EsjQlh8yy4u38/YZdfkX0GKG1Zpx9htBjF4MzUxrXMR
 1t5b3zRPENAmA3Ob5KRpICNK77h+axSaEGIUGCG4bnAWseo6aF+nKk8zYdxoZbXZKbNB
 boTtv6upxauTaMaI79NieiZOovN+Cd1iDVSBhItVvouGfOGgH6fxLKNDC1xwxY8AVbns
 Zfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=TWVBhHy0WPw0GotWHFiTstZdugISF/16D3zScGhJWms=;
 fh=ZZyEDQQrpMGN+93C+nWCKA85F8NlBoZRGypE92/ZoLw=;
 b=JvV4fcagHxYVOD484y/FW/C+H+AC+/MJvF/AVt8zTvUsvN/3aSaGDv9E2qIFt3oPUa
 mAzWNrcHlhjN585fPGjNYkgq99KJPTWc8RGhiHHjAxEq1c59bVhGb3Y9OJ2BI9KkWoCE
 +vTeF2ryIx9MYQ3QwRMzltnD5/2GTtNqp2l473a8Oolt6PqYTqvf/1TMHk7E7U2wK3Na
 9429dVg/RLaG1L/Y+W+7Itx4M5A021IwSIRQzco5gmmYGOMPkON5jT97Pw2nmysrygDB
 ZXkmF0eOwNZFxvtqco3bo1UHfoZMGX50j7HnyjSFMAVwLB0bUKnMuxAXf5sS3hYjpsHz
 CW4A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280699; x=1788885499; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TWVBhHy0WPw0GotWHFiTstZdugISF/16D3zScGhJWms=;
 b=dLIEWHcmSrOIziPPs3N+HJxF5iNMLljWnmY650sEWE0ZFp+UQfBX0VJ1HNFaZ7CFA4
 QUQe1IxfoY4QKtKwXOG+eihVHWZwRk5QDqKgKF62cipNd+I5dyaXSaLHmhc6cIcDA7+n
 TOSkERd7VpCsBhIGagIhehESVm7m2pA81VGSqH6BuhRW46fBc0+ANLAJRzqzf0W3RloX
 uYpjr7F48pUYzx3O3P35snn/FR9zvznQ+xApbwCMzeyD2dIDZvvEsgYvYgdWYAfimSid
 9JJVR92FRFtphkhYJIVxHLaRiHSXjzXBCFtPMntlcJWdzCCfVu+H7ysLiqwxvqU3urOw
 QEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280699; x=1788885499;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TWVBhHy0WPw0GotWHFiTstZdugISF/16D3zScGhJWms=;
 b=jh6D1xx4hWN+1CJO0cXVjHJM5Su3IXl6binMZgjloT7uQ9B9MMi94fVRtx9Aglo6Mp
 tMjjF37rzlMr9zdQvxNjXoQv10KrS+8cnyMsubitB/NlEG3+mA9qFH2emnuZyfpefB/n
 kSt4IfmfSXyYu282dUL99WlfkLavudjnqWDRWo+XRCJinhgBtk0wFi4d2SxU6oQGtaCy
 6rKtyHuXtnYfiyUmqZz2isUgs1ga74MghcbmhalHQf/mArlZeKWZb1nVoSNbJvejlbYv
 hUtG10+pqkSbjgqvhLdOHMjEGsrKACw4SvLb13fvggXhqm27KJLI84U3aQ+vY/Z/vHJO
 CD7w==
X-Gm-Message-State: AFuF++lwO4v0YCNqKL9sJJ327INtP787F979ROmd0EDiVv3/oITLho22
 fI6fceA+23UgPDUPsiWVUZYbXO4OaoVp49c0TlHThG3xoTJkUDHRHRGNVTFpH+nN7JSHYE6slQa
 DtY8ITWyMQk/Q/pbrG2CsI2plNW56E96UJFYGT10=
X-Gm-Gg: AYBFou2TROH9Vqk5njoZUp8e24SO92RV/W57l0iCbjPhyxt84c6jXN7FgJIcQ4PpAE1
 pacT88IU+OMdc+K6WfLt7KUaRNPeDLA8WWwTFbf1Co+QY/Kq8R1RD7hcG9b09zsltfPOMZDDgU+
 sY5drshRsdp5Dip064dboAzjoZeUs4bIvgd0k7Mu22qOOUMrgzWH7xXUArCKGm1rQfVu2Vd4SR6
 m+lOuByVqi7Sv7TmpcKyaV5/scfHsdSTYy5BpO/NUHZb0sbuZss5mtK+RWbC1d4DoJINwy5viXT
 0WwTzx702KF4YOAogADFEnVUxVCcw0xpiNjSWfghF5OLo0f/mx127iOZrQCu+FTuysit89Mh2Fa
 k2w==
X-Received: by 2002:a05:6402:21ce:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a663ab81fcmr7846829a12.10.1788280699162; Tue, 01 Sep 2026
 09:38:19 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 11:38:18 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 11:38:18 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACOAw_zvoYvdLWjUYpj1ambnjzPpzTOzTp7zGWA-aF=JqNPUNg@mail.gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <bb5a74df5ba223cd33b4b7111e725e5aa315f79d.1788213716.git.zhangxp1998@gmail.com>
 <CACOAw_zvoYvdLWjUYpj1ambnjzPpzTOzTp7zGWA-aF=JqNPUNg@mail.gmail.com>
Date: Tue, 1 Sep 2026 11:38:18 -0500
X-Gm-Features: AcwNN1U6jROIjyCl3ulm0qgtURd8CUn-gJJEkY64oOjY0QTlY8-WRb1jNn0TGgI
Message-ID: <CAH=xXfGOQ4zF+4=i5o0drHHFmMFaY-mrgTCp473BB5O66fEgug@mail.gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1x1RVC-0007Lj-39
Subject: Re: [f2fs-dev] [PATCH v7 09/11] f2fs: parameterize byte and block
 conversion macros
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks. I have restored the shift-based definition using
F2FS_BYTES_TO_BLK() as suggested, avoiding the
DIV_ROUND_UP_ULL()/do_div() path.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
