Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A14606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S2gIoOR5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kbsqs4LG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TgCABEdV;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQEoaedS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=M06yToWUSUtsBqi3IJntcYKtw8Jx3I5MCYUXQg/WuCE=; b=S2gIoOR5fNdZdOAYCkXxmxjl9h
	q8wf5H/0SKbokfZCuqYN8x3KHMgBj10wWhVdPsoIMJaLJDzxxGwvDvdWKGcdkUlhG+5rgYIsJHjkv
	E2YTGnRu/dpIgZ/MdHuElc0n+VFCWK0h4l8Pd3Fs9blY9WrkfXU/fZuFnaiJQmEUFPJw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR5kl-000000007MP-2qgC;
	Wed, 11 Nov 2026 10:40:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xR5kN-000000007M4-0Nbr
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vvw8pGMMvdXfl1xLQ0CKwozeJ7V4XtvlfJfweWh1jGU=; b=Kbsqs4LGhs5yBy4oxw/mhCwqjB
 d2k5ha0XCzt/hVdlE8HtuWuRAu+ytZkfgyLHp4zxxwPyufMgeUIAzJD3WppVlFJ2HyVnDZUmmqYLZ
 7UNsxArORpt6IeTS0/uTjt/yBqJc33yYCcfwwxk1jx6Xe8iFM69LB3QW9Iudz54kjMcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vvw8pGMMvdXfl1xLQ0CKwozeJ7V4XtvlfJfweWh1jGU=; b=TgCABEdVqNBkqor9U7+gusUawc
 t+JvHRn6eivxpdjzuJ3MTpdM8fzcuO5XuqY5LnnSU7ZLXn0GKUOd6YHtEhiaVMmtLvwxOCQPSfJyZ
 fURu1XzNqY/V6+ZcVSPak770vafNPWblPQV+FrZp1vJ+Au783tSrE1ad3aaT75tjtKfw=;
Received: from mail-pi2-f10.google.com ([74.125.227.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5kL-000000002d5-1u4C
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:40:07 +0000
Received: by mail-pi2-f10.google.com with SMTP id
 41be03b00d2f7-cd697a57d7eso802617a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794393600; x=1794998400; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vvw8pGMMvdXfl1xLQ0CKwozeJ7V4XtvlfJfweWh1jGU=;
 b=AQEoaedSrOx1FLxOVX86BgszTOlpQzYJC8b/ixER/6rCAya3FLF0/JnnrTeVdZZLDA
 CJrSdXBgey725qDKIQLEngMKVbeVpTr6T21zaF4b0KheDPJ9cdT76eRHSh7wNG3Ec77W
 XGcca5J3T2/fmzAKA+o40SxQtD4U7j49fyZC0/VTb/QXJK6EpFyRWn1JY6968ueOM4xb
 Xk3TFepiO9475JvKPs18q+/cXoZJVay+26XeXLQIlYEaqdW2t8GN0pDTY/2atImxA1sF
 QN21wnT800EebWb5Mle/tGJ0F6/y+Cy5ohYcf+Z5FLc1aZQ5Fp7CKCZoR1jLQ3MOr5ae
 TSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393600; x=1794998400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vvw8pGMMvdXfl1xLQ0CKwozeJ7V4XtvlfJfweWh1jGU=;
 b=iKYY4tW5JoErvh1LRtMbeEdNPQJoksVqzfTLTaZ+bGM/QHeoBo/f59wyHvXBRYDevA
 XbDGA1pFQbLL95OIzRfXgpGXbiNhyLHT3b5dtzpCG9VSwkXg0HflYHdLE1WmFzu66bfq
 di2ozqOac4Jyaeg6HLRAtvADrTunKsuY+8jko+Hq8QFcWSMNZSUUzEWTmBVr38yKmwkt
 M9ALMaRL58KR2nwj4Is59KJcK+cqIZdznN+7pQwyh46rYmqaIvT29O7CBHAZz0NOBMNL
 Ni9q917MvDQGyZuLX5sYvaX+c0iCjKzLut6zDKmWqxDT+bxMSZK3fszrP6svKS3cDIl6
 NISg==
X-Forwarded-Encrypted: i=1;
 AL+hErF3HtauUA1o4MMRXbXWhkG4VeHzUuT9RomF+NztdY0ME0dPlYtTvahsCt8CRAk7dHc+VIwA5aYHzji5G2PzO0uI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z96KzZCnNCPHvFUuCVsUXaRK49nBDXGC+tKyLT8Myt6uor2t9L2
 9LfjzgzgnOVF0sp07CKHsaAmWukKFaPM+A/1YMzCQzqk91F7Ox2+ddnG
X-Gm-Gg: AYBFou1jEdaHso0WCoUUFpJr64ZNQDdW58gW39+U/Keo5fEnmkE7qacUxzueV0tfNmH
 uFtHQQfNLH8cInZs9xAyVQi4cYyZNLr6KFOA+czKfT6/Si432mMw5arsPWaAGX+LAFeIsxMsVuH
 5lA7EGD2Vn+9GCCuArEw4DJckWkdb0qn8eO28izyItGJHkvQEZqvwWjnpmFlwSLsBSJl607i2k+
 PGgvIJABCHtBHTyhothE68LaFHhoKsAra9V7mLNHNK3YyqB3u1V132ANs59DTKtnlkKU15fhM7X
 QY2oYJL3hP6aJuU9PzH3LOf0nfwnA1ibTW8Mw8aOIFTKNBoBWsLOnQ0NpaM5RGXBKxhfMXCx7b6
 +a4cHsqh57Y5KB5aTxM6DFoTacvKoZCcWAKoFtlkT6Tj9gCsprqgZh9/im2Yle4ql2nCI5Ms6af
 zKG8IVZvv1sAUE1VDrnQ8TEwTHXJckMvQBMZTEAZI7o/QdrHql+x5cZuK9NUFC/yt/OAf4UqJOV
 vB+Q5zo+fvquRuYwsdI7sk4BO0D/v54VFcoIfrHTX0nwaq17zsmi38j+wnJTj/a2CpxzNxrTuwT
 5rAMK78knievtfBCC5h/t/jQIvqaq9MtDqYjxog2tBpmL2OaH4qQfco8y7BHuLjmDkA=
X-Received: by 2002:a05:6a00:3022:b0:882:6d80:e5ad with SMTP id
 d2e1a72fcca58-8bc1c4999edmr1960515b3a.9.1794393599641; 
 Wed, 11 Nov 2026 02:39:59 -0800 (PST)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab1228e2sm2065878b3a.41.2026.11.11.02.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:39:59 -0800 (PST)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: Daeho Jeong <daehojeong@google.com>
Date: Wed, 11 Nov 2026 18:39:42 +0800
Message-ID: <20261111103947.3560570-1-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_ypOkWNWW8=8fn8gmnWnwrFDENYCHT-mXKjSEOL-UCYZg@mail.gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-4-daeho43@gmail.com>
 <b3c98bba-69c8-4350-a9eb-0942be336f93@kernel.org>
 <CACOAw_ypOkWNWW8=8fn8gmnWnwrFDENYCHT-mXKjSEOL-UCYZg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR5kL-000000002d5-1u4C
Subject: Re: [f2fs-dev] [PATCH 03/20] f2fs: extend f2fs_folio_state for
 subpage blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daeho,

> - Make the uptodate and dirty helpers take block indices. Allocate the
>   state on demand with __GFP_NOFAIL, so callers no longer handle an
>   allocation failure.

I remember you raised this concern when reviewing the large-folio series [1]:

> I understand it is used to avoid failing in-flight I/O or writeback
> when allocating the subpage state. However, invoking __GFP_NOFAIL in
> memory reclaim/writeback paths risks OOM livelocks under extreme
> memory pressure.
>
> Ideally, we should ensure ffs is always pre-allocated during
> write_begin() and page_mkwrite() (where returning -ENOMEM to userspace
> is safe), so that the writeback path never has to allocate ffs on the
> fly with __GFP_NOFAIL.

[1] https://lore.kernel.org/linux-f2fs-devel/CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com/

Now this patch uses GFP_NOIO | __GFP_NOFAIL again. May I ask why we changed
back? Is the livelock concern no longer applicable with the
subpage-block design?

Also, please note the warning reported by the kernel test robot
(lkp@intel.com):

https://lore.kernel.org/linux-f2fs-devel/202611050144.47BOVak5-lkp@intel.com/

It reports:

  fs/f2fs/data.c:5196:34: warning: variable 'ffs' set but not used

in prepare_large_folio_write_begin(). This appeared after the
`if (!ffs) return -ENOMEM;` check was removed in this patch. Could you
please take a look and let me know if you need me to send a fix patch?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
