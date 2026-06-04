Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849C4CD6E4A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFV5S43mvxFJJxamEAAir1vOHgGPATrWuGns2EehUY4=; b=H27MlcRUsu3m23Tco0y1uY4S0K
	PYpVMiyNaPvzTKx70e6VOASJyK+kVjtE4LN8qUHkp1D31Hwx6rJphtQ3B92XFOYI260r6ZWmQTq8Y
	NZK6Z+6C/w5cCamUVFW4z2XuzNJhvYF3jiKsfu9egNwnao/n/1j5vjMLpNWvPZuMKra4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wV40M-0006mq-LS;
	Thu, 04 Jun 2026 09:04:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1wV40J-0006mS-UD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jun 2026 09:04:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2lQs9dI0tAeFPaJ8i1YwQIsal8XYYdyr4lp1F85T2xk=; b=BVvxw/oKoxtbLGpYN3mkCBxAEg
 QWYfHRdlgmzpTglshNV5XG2E1i67bwse/TChJYau3/OK2xan6x1GSSA6CaJwP96XldpN6RQ5Yhj+A
 nL61VpqqKsn0IVsQ2xE+rGa9gCd7OSRsQcmNI7Y+OeG/QJE/I6K1ev9RVMdpLDR+JxsI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2lQs9dI0tAeFPaJ8i1YwQIsal8XYYdyr4lp1F85T2xk=; b=bKCbtZHhXEyosSkUHfpKt4TXHM
 uoe52Fg/fDEWntV0mBm5hs0ztxKpv5+SECe5THmosZf2hihlYpIKHhdiYrjJFuVxWOXQ1panXm/ud
 V8qVCKNCm+QaLQ/ztg5xhs+VWKiq6cIyPOR5NQtSFmz+uNFa4yH1vLEp/gIvNAXXQPW4=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wV40I-0007b9-NR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jun 2026 09:04:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780563876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lQs9dI0tAeFPaJ8i1YwQIsal8XYYdyr4lp1F85T2xk=;
 b=OX0cU1VZzlzQXUJiY0B5ejGyseFhdkB4n7aBW/tHtF3vXB6jvkQJ58nYLfVWzAJrHwxSGv
 jl5i5uSfsa7NYGN30V658NXVInBl/ALnwYReJ81SZZigU7zNkTW5sqVsskKpYoT5GQfrkO
 HSm0xNw3D8LRQjrm+UVrrRfE93bd1Vc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Enz7nxO_PRyoKGS9HVjuAw-1; Thu, 04 Jun 2026 05:04:35 -0400
X-MC-Unique: Enz7nxO_PRyoKGS9HVjuAw-1
X-Mimecast-MFC-AGG-ID: Enz7nxO_PRyoKGS9HVjuAw_1780563874
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so305731f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 04 Jun 2026 02:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780563874; x=1781168674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lQs9dI0tAeFPaJ8i1YwQIsal8XYYdyr4lp1F85T2xk=;
 b=ruX0CrHStSG0V7nUD0WeX3JLTM3NAiVtq9IsfJMMsUXPDT6KOxMqh+1As4JLT00y77
 uwii496gLxiBlCi8xJDQcxA4NcFhZ25BM7O5yI7ztBmJeZzNcuxXs/VqE4CrdTo5jjWn
 sqqNGZF4IsVylswhakdujy2ICVFhpG/6z6BsHOi/GS1/HuDsFSYxXqxGT5s9/qypnSeD
 eulwjvPH58vNBXg9CHbdpvaGUTAGFhQcM5vcpW1niuT7ECt1iupo+G27roV7gc71+VhQ
 6fms6CrQFRUTN8RMuNmXc+63UKKM4yjykatkdsjk3wAgdJBTxWcPoxh3Qn8X4wc2mvlZ
 vtiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/9rjp9mUhh5gHRDYgBMUsy1xMX62No38yyJ69ez6Tl7Fkd9Fs2t0wtqwRAn+lppBIo2bbBJdS14tSTtXndyQ2@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzkx1AB1fM9PqcXouZUk61mju6kwP2DqCI8L0oxJ9HSuV455muh
 1peU984Uaj9h+0nMXEkBl/TfG+Nqh5KbfNSPy73qf767GpYcPaGBGuF4nOJjHFhurtPQ9ke+zw2
 9URGfiQ3jftWBF0rJcv/ACConugOGvpDWzDAemRUABzBYOg0KRCencYu1WpIXT6z8tJwb8+td1z
 GsvQ==
X-Gm-Gg: Acq92OHZbOCry97bT/rC64Y+/ZvFqWDH8lk47e5WOZd6mgpQ3w2CmXpYB5mX2hhY+Uz
 SkRHho5d90STPiut6jM7FmzhJ/AI1jEzSIEDrrsWKhWiRXU0WXuNgi2TTdfk/i2+Neb2XBelj6E
 0P7/eNwcqEH0zzz+3zn37fRH+ObR8X29a93Ev6SjmBQGbju3KJ2M5vOrd+JT+oi742W1mu1K/zz
 c8MOoP+JMFXnMhIk6WYI9fF0W6JJ/EHe+TVoVA2EdZTWen91rdLvTdoAFHQCLoPcIVCCQJmzktm
 RO2SHwoMIot1ipzZOME4B/RsLX/YkinroNrfulDuRc9DLAZnGeUDPQtNlPCswrSf4j6xIW3K9qS
 TerJSp4kWOAluuzwOTxPjEPsZomssGbyJQbQwtddecgCYMZ4mZvEm4IZjJMMH9Vp8Dtc=
X-Received: by 2002:a05:6000:43d4:20b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-4602182b90dmr8717132f8f.19.1780563874001; 
 Thu, 04 Jun 2026 02:04:34 -0700 (PDT)
X-Received: by 2002:a05:6000:43d4:20b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-4602182b90dmr8717074f8f.19.1780563873372; 
 Thu, 04 Jun 2026 02:04:33 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm16539954f8f.1.2026.06.04.02.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:04:32 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:04:32 +0200
To: Christian Brauner <brauner@kernel.org>
Message-ID: <aiE_YQc6SGSdWlcE@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
 <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
 <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
 <20260522-unbehagen-baumethode-erlesen-811a4065eeac@brauner>
 <20260522120757.GA21041@lst.de>
 <ahVzkf8JoKP-kSC2@nidhogg.toxiclabs.cc>
 <20260528-offiziell-luftleer-misswirtschaft-3503bda2ad70@brauner>
 <fjdfwhwi4aogyiaoijwvw6w4npuu5mbt6ua6fkhwcp5ajlm543@ume2fkxg36cb>
MIME-Version: 1.0
In-Reply-To: <fjdfwhwi4aogyiaoijwvw6w4npuu5mbt6ua6fkhwcp5ajlm543@ume2fkxg36cb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eVMmmWIVcqTN9v96UER2N_8iJS_CJhbufogvpTdw-S8_1780563874
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1wV40I-0007b9-NR
Subject: Re: [f2fs-dev] [PATCH v10 00/22] fs-verity support for XFS with
 post EOF merkle tree
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-05-28 16:50:45, Andrey Albershteyn wrote:
> On 2026-05-28 14:20:08, Christian Brauner wrote:
> > On Tue, May 26, 2026 at 12:19:43PM +0200, Carlos Maiolino wrote:
> > > On Fri, May 22, 2026 at 02:07:57PM +0200, Christoph Hellwig wrote:
> > > > On Fri, May 22, 2026 at 12:03:20PM +0200, Christian Brauner wrote:
> > > > > > I was expecting this to come through xfs tree too if Eric and Christian
> > > > > > agree.
> > > > > 
> > > > > You may take it through the xfs tree if there are no conflicts with
> > > > > vfs-7.2.iomap. If there are I want to add the iomap changes into
> > > > > vfs-7.2.iomap that you can pull in.
> > > > 
> > > > Merging the iomap bits through the iomap branch might make sense, given
> > > > that iomap usually tends to see quite a bit of activity.
> > > > 
> > > 
> > > That sounds good to me. If you want to go ahead and pull in the iomap
> > > bits, do so, and give me a heads up when you do it so I'll pull your
> > > branch locally.
> > 
> > Great, can the series please be resent based on current vfs-7.2.iomap
> > then please? Because the iomap changes in this series don't apply
> > cleanly on vfs-7.2.iomap so we already have merge conflicts...
> > 
> 
> hmm do you mean this branch?
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.2.iomap
> 
> patches 07..09 seems to apply cleanly. The only conflict I see is in
> the overlayfs patch 03. This is because [1] (is in -rc5) is missing
> in vfs-7.2.iomap.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/overlayfs/util.c?h=v7.1-rc5&id=0c8c88b8eb82a2a41bec5f17c076d6312dc40316

Christian, ping

Would be nice to have iomap in vfs, so Carlos can pull and test the
rest

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
