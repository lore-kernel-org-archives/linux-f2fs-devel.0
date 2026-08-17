Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE14AC5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/Nit2WhpAIOLUlTZDSViRqO0rrT+hvN7LW8veJW1WU=; b=G4+0Cf5x+HS/g5DrmA2rKthHVA
	Yhoa4Z0AXLG6Yq/DbHU2CtwaWPwPQHk/jfj9/Z114T6ViWOfWO12E4L18RTuiV/uX+F8uDMChUZNz
	7KSPbJ7K6hQ6lbl5Whd71nVWaGpp/qGleyB4NtWtXzerGPGRZuPQqRjoYI2tBFD66ofg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvpau-0004e3-Uy;
	Mon, 17 Aug 2026 05:09:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1wvpau-0004dx-4M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 05:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z/x7VDroEtisLQTINSAgqdabiGVN6bRi+UuVMbVvFgk=; b=ljb2jYNTbEtadyLTHkpbS5DHrt
 8YzsGXiVCPZ2ZpjrEZ5jWiCYBOQtYaAoperZXw5VZo+06Bk/SfIwVZeizHZdis767LJ3Nz0o3BlAL
 bDRw+ZUzckpRnAfaKMvstyUIL7nLZ9P7gy/I9cozPLy0MQG9BdARb3PhzZa9i/tVzvLU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z/x7VDroEtisLQTINSAgqdabiGVN6bRi+UuVMbVvFgk=; b=IkspsRWD8xVnwv0HCnIaq8louP
 2TB6G+xenYH+MoMG1twT0MOSj17v9Bbrqd6DYV6R2xfvcXQrkVvNA8PqpNJEGhxEvhNDGsu1C6AH/
 iQmd4nDEJWsPq4U2Whv2fGCEQaI1rs2+o3FSXucHZ3eu3TgHSfmGanq80NCrt+huhGNY=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvpat-0003P2-Hb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 05:09:08 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so2922227a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 16 Aug 2026 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786943342; x=1787548142; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/x7VDroEtisLQTINSAgqdabiGVN6bRi+UuVMbVvFgk=;
 b=NqaWUSbrttmA+5vUtm2gpGTDRTpvvtBiH90tfsWYwotBGu15rdY+giKNiKiyl3BPu+
 576xJwAxx5M8aLXKHkyo3VPpifghI/9dFzYfBV/8zOxYvCDzQcPd425cQ6y40T9L5T5W
 T5nvLm6f6pgEryIOKU8fRzVp0DFKAIB+zOCIzwf3zqrYx0WPgPtexVEHtlUVyv5qdudX
 ogCP8GW9ZdGaXOKAV5sJvkh7//z9V+1uRPQtboMKz16yf4JSaEPmuJfYBp2ekLltAi1m
 W/3XoRCVKAIThRQIo1DjppWmB09JeVnhbNoQqpp1lFRvmfd4fGHyPnXwqNFuWdkqe4ja
 +CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786943342; x=1787548142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/x7VDroEtisLQTINSAgqdabiGVN6bRi+UuVMbVvFgk=;
 b=CDdukddGVfUESfQ+f77LnSfgAQY5AMuTHY/4djgc4XfonJ8PwbIQZPSWA8P80BpEjd
 61yC+2PsI9OcJcTW6TEP4mI4AV31e7WnHqarzHHLwvVbsXJuSZHqbwappGGnLfzteppl
 lLaOpNd56Z0xmeTEbRZCOLfg/blhuat3PYRdcmyX9z5e/pvLbieVDTeU2VBsg4Vgmcd0
 Pgfq1OnHzxTVOLfpnARr6l0NeRYKYg8sIykYtZiEtYe3fGIrVg4bWgiQDCZYMOfzNO6/
 SeJXggxWrlztrE1N1/94u2g19V+TDf6y6+spfS8tusZWLn8JK5RGjJiXe++jj30Ppr7f
 qQSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOsuLehyzBJfulkKrI1aLfhZ49e1PQ+I4x9uOa4ORLFy+vK8GVGmbJmwMtjcTU6ICNGw6DvmvsTnr6dIAQXwY+@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzGUzNQDuc25eTOH7wk4q2MiWtKniHqq9jHmKQwNcq0mB4qRoUG
 gMnYK+9kGiT7cJfPPXadN8yWfMm2nKeREgZmsBUamUt/0qBudhBV3sRX
X-Gm-Gg: AR+sD10qxNmavmkKrxi0KAJ3FEIOR3rd7xBUp9PyIcI76CAoKrtE6BVqNg/1+J4o1EE
 6fJq+p+6ABp5UNF30crh9z/jXWkOKNK0Zo+H4L4g7WpQkL2PgizNloTR1XpjI2lEvBX0frsxZ5s
 mR6a1bDOrT2DuJ4HNrd/yfzWMMRLZKP7xZqrMDicT0s5FEbpIwS3oQoYpkIQyGKE9S3D0z85S6x
 FsYO5J/Z/ybhclXi9AGZWep1VGUz3zYUInQqVcrwAzaQ8mpSA75i1BitwUmSg7kJeSEXZZ+llYT
 sf9e/zD6UM71zx62fFFTRSylt13JM4Q4PGydocImdo8C5yo4GZXc8yWdTLLMmH5z9nLlMEewElA
 hj4RTO8kk4abzTjCLfIGc9YChQvukLxemap9azO2pK0tM4Ouj1Eg8QqF12tFdUUcv3Q40zcQRRU
 MNlQOURSL6zwke8cQyAxjtcXK+zQ+7892mNp0pQWoT0dDGIWL1kLhrVZGj+qJ2+yghTrN9wI3V
X-Received: by 2002:a17:90a:dfcd:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-3933b503abcmr23137686a91.0.1786943341831; 
 Sun, 16 Aug 2026 22:09:01 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3954d3b3b91sm712731a91.13.2026.08.16.22.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:09:00 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Sunmin Jeong <s_min.jeong@samsung.com>
Date: Mon, 17 Aug 2026 13:08:52 +0800
Message-ID: <20260817050853.3437985-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c3a4a131-4a97-4227-8968-03fcd491c0a4@kernel.org>
References: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
 <c3a4a131-4a97-4227-8968-03fcd491c0a4@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wvpat-0003P2-Hb
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix i_size when pinned fallocate
 partially fails
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/17/26 11:12, Chao Yu wrote:
> Can you please provide a reproducer?

It needs a start offset that is not section aligned, plus a fallocate that
hits ENOSPC partway so the error path runs with expanded > 0.

  truncate -s 80M img
  mkfs.f2fs -s 1 -f img              # 2 MiB sections, sec_blks = 512
  mount -o loop img /mnt
  touch /mnt/pinned
  f2fs_io pinfile set /mnt/pinned
  # 2093056 = block 511, so pg_start % sec_blks = 511
  f2fs_io fallocate 0 2093056 536870912 /mnt/pinned
  stat -c %s /mnt/pinned
  filefrag -v /mnt/pinned

7.2, last extent and i_size:

  ext:  logical_offset:  length:  flags:
    2:  5120..   10737:    5618:  last,merged
  i_size=46075904

  i_size block 11249, allocated through 10738, overshoot 511

With this patch:

  ext:  logical_offset:  length:  flags:
    2:  5120..   10737:    5618:  last,merged,eof
  i_size=43982848

  i_size block 10738, allocated through 10738, overshoot 0

filefrag prints eof only once the last extent reaches i_size, so its
absence in the first run shows the mismatch on its own.

7.0, before 4275b59673eb, also gives overshoot 0.  Absolute block numbers
differ there because the start rounding changes how much fits before
ENOSPC, so only the overshoot compares across the three.

I will add this to the changelog in v2.

Thanks,
Zhan Xusheng


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
