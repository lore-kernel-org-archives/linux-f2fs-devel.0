Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CA7CD6E6B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eYirVfs9BfJecZGQ/goyYeliZ9QRMnFcIhhbohU9vY=; b=mAeqlFHXaF1w9yaGSEdbAPx05+
	MTvxD/UPyMV9/OkwoEI6CGPc4rQS5LCx0U8JxTypDkTtbRNiTdCufjBK8vUBmwsjUUXfncw5ufT34
	qgZ82jlQGDwb1vqYpefRe+9Wt+yIsjvHiufKnrEN7MpbIHV8LQ6stwpJ0tOoqbSbN2z0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wV6rG-0003xT-3U;
	Thu, 04 Jun 2026 12:07:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1wV6r1-0003w1-8I
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jun 2026 12:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vez+3z7s+CL1O/+Z7LdAw9UEUl93TBeC4vinR18yFpA=; b=KobvClDQX4DnKrA57l6nx0Gm4n
 i0ZeawagWuRFSNvY1fzZVIrjjFc3V9kS4DVTWMn2ICpTA69Da9T8PjY9L38vrSQRgQQyotZY4LGKw
 uFjtqBhlzIfCdpzkOqQcC/TxeB79CLCxwtiNXKq9PeF6YeT7ca/WeGMpfqIh3XQL0K8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vez+3z7s+CL1O/+Z7LdAw9UEUl93TBeC4vinR18yFpA=; b=IHPiY+cS4HuiR0ysYkkbt3wbPh
 G6DZPV/xyRbo6GdEOCyLh8Gcnd4E0P0ntYoG3uWG6BjKSJxJzgs/Bgid7V0jv3lFBhgPmkbV5Lyec
 uQh2nZpmAtZQk+sPlOv7xhN3iJPL0//apO3lGpoaUptAg36DNO3ucienNWOnIMh9ritQ=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wV6qx-0001cV-97 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jun 2026 12:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780574829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vez+3z7s+CL1O/+Z7LdAw9UEUl93TBeC4vinR18yFpA=;
 b=PKlgbyUrijCDT7TNd+K6TEJ+OWo9tsKbtrlouGBKlarS0DKDEGEQn61Zub5rv1aPcMMcnc
 dOIBa8yQzgJxY7HQ/DCf0Y1eKqVDBIcRJY9Y5qpDNA/BLdmxpV3PnUtacRU+l1n1n9GdD/
 T8pWDbsxfmyD+34lVXaV8eU7BW931Y0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-8WqfrTT1Ps2Er79a5BXmEA-1; Thu, 04 Jun 2026 08:07:08 -0400
X-MC-Unique: 8WqfrTT1Ps2Er79a5BXmEA-1
X-Mimecast-MFC-AGG-ID: 8WqfrTT1Ps2Er79a5BXmEA_1780574827
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so407835f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 04 Jun 2026 05:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780574827; x=1781179627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vez+3z7s+CL1O/+Z7LdAw9UEUl93TBeC4vinR18yFpA=;
 b=HJmDM3fRV+rmISPO8bN3khUyStXaHOvcUBGTpuP74k3haJRMU0Y4BGQQLDC9sOAOrK
 +wOAnCGWbJtANdVelywQpnnlTdvjcXslMbPVF6qQmEs0p71AWHYJeJGAvO9O0KFLoP0m
 pzNx/5DeBlRFPtuly8GS6rSD5vkuC2CdTf0qPwSf7oGpS7SCcmAO/3o07EfdApJt72fp
 DP0xJsHwx9sTnpeto67kup9GAOoHPTjj1mC7FC/TdOWtI6CxNTHmigPLnlLdSoWGPN5X
 QlVBTJUxBnLQeXGPB2fmHtWo85bjxwC22u0bbwccoenH9tzdQW60Gs2nMw5eCnS+pVik
 GCMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9arSkrGY0kvOJbuT+ekbhTYnqsbUSavTiKRSRd1kneHYhbDZ4ZmMJVUjfxQFkbJzsqEPwA6kI52fvhKLM01Vrm@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx18TagC6WToPPxuKQdYo0Kf4u0/0pbI+ueqCWmg7GvlLnMQOKp
 1v6yudPSSc2LSjKH15vDlH9ql4wOOVEJyB+3C2X1KNHQc0tc1c/FuuuJdfFisLuPpAC2qV4me/z
 JW5d+sQpazEXl7NEd29+3Pu28aYUtvspj35PyDz439CiZWjwaalcKlRIOksPL8Q+EKGTvL8Dxic
 6coA==
X-Gm-Gg: Acq92OHiQB+i2pqNxQsJpSZ//pgZ7+sokK5U4ZLkJheT9XCrX8vBrhR09OGAbwHuorZ
 mi9aOWagBfMTVNt/1loL4kyf0rLY9XHSPiQ2PJvfPAsc9ZndfnCiE/ETiZaYZI8Zo0HKdX+1IuM
 IFqNnOpFAeLwYBxXPBr1+hl6ftjyp1wAndOL2aLk5/23TmZFyrLsMuuKC0pNbZ0beHUXObr0UQi
 gQvX5Vt7HnHVUEcKoCN+LWIJiuhzRD27L0Hs7EEc7TNHRpO24vHtjkj1zmU+LfuFBFLb3P1PN85
 qQJyzIjR4YyGBqUMHDTudEnPHmaV+6fxfwMRqw2BnipU/F6jtmyvwhexswq0R4vVIyQFR4Xc16K
 /X9r9h+D6/8+UuFllW29JYA==
X-Received: by 2002:a5d:6188:0:b0:45e:ea3a:47d6 with SMTP id
 ffacd0b85a97d-4602185fed6mr8733077f8f.32.1780574826825; 
 Thu, 04 Jun 2026 05:07:06 -0700 (PDT)
X-Received: by 2002:a5d:6188:0:b0:45e:ea3a:47d6 with SMTP id
 ffacd0b85a97d-4602185fed6mr8733005f8f.32.1780574826279; 
 Thu, 04 Jun 2026 05:07:06 -0700 (PDT)
Received: from thinky ([217.30.74.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm15892014f8f.9.2026.06.04.05.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:07:05 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:07:05 +0200
To: Christian Brauner <brauner@kernel.org>
Message-ID: <yezqqgowgmbn2z42zvha7cfcprym5vnurb33brdmooab6csdks@a76a7v6rtywn>
References: <20260521090705.GA14254@lst.de>
 <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
 <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
 <20260522-unbehagen-baumethode-erlesen-811a4065eeac@brauner>
 <20260522120757.GA21041@lst.de>
 <ahVzkf8JoKP-kSC2@nidhogg.toxiclabs.cc>
 <20260528-offiziell-luftleer-misswirtschaft-3503bda2ad70@brauner>
 <fjdfwhwi4aogyiaoijwvw6w4npuu5mbt6ua6fkhwcp5ajlm543@ume2fkxg36cb>
 <aiE_YQc6SGSdWlcE@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <20260604-holen-rundum-ausfechten-2193b39da363@brauner>
MIME-Version: 1.0
In-Reply-To: <20260604-holen-rundum-ausfechten-2193b39da363@brauner>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c2l5O5_9s30SK7ZOGGOF_pVDpzjmlXXSF3rkyn8hoxc_1780574827
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1wV6qx-0001cV-97
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

On 2026-06-04 14:00:07, Christian Brauner wrote:
> On Thu, Jun 04, 2026 at 11:04:32AM +0200, Andrey Albershteyn wrote:
> > On 2026-05-28 16:50:45, Andrey Albershteyn wrote:
> > > On 2026-05-28 14:20:08, Christian Brauner wrote:
> > > > On Tue, May 26, 2026 at 12:19:43PM +0200, Carlos Maiolino wrote:
> > > > > On Fri, May 22, 2026 at 02:07:57PM +0200, Christoph Hellwig wrote:
> > > > > > On Fri, May 22, 2026 at 12:03:20PM +0200, Christian Brauner wrote:
> > > > > > > > I was expecting this to come through xfs tree too if Eric and Christian
> > > > > > > > agree.
> > > > > > > 
> > > > > > > You may take it through the xfs tree if there are no conflicts with
> > > > > > > vfs-7.2.iomap. If there are I want to add the iomap changes into
> > > > > > > vfs-7.2.iomap that you can pull in.
> > > > > > 
> > > > > > Merging the iomap bits through the iomap branch might make sense, given
> > > > > > that iomap usually tends to see quite a bit of activity.
> > > > > > 
> > > > > 
> > > > > That sounds good to me. If you want to go ahead and pull in the iomap
> > > > > bits, do so, and give me a heads up when you do it so I'll pull your
> > > > > branch locally.
> > > > 
> > > > Great, can the series please be resent based on current vfs-7.2.iomap
> > > > then please? Because the iomap changes in this series don't apply
> > > > cleanly on vfs-7.2.iomap so we already have merge conflicts...
> > > > 
> > > 
> > > hmm do you mean this branch?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.2.iomap
> > > 
> > > patches 07..09 seems to apply cleanly. The only conflict I see is in
> > > the overlayfs patch 03. This is because [1] (is in -rc5) is missing
> > > in vfs-7.2.iomap.
> > > 
> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/overlayfs/util.c?h=v7.1-rc5&id=0c8c88b8eb82a2a41bec5f17c076d6312dc40316
> > 
> > Christian, ping
> > 
> > Would be nice to have iomap in vfs, so Carlos can pull and test the
> > rest
> 
> Applied but note IOMAP_F_FSVERITY
> changed from (1U << 10) to (1U << 11) since we have another flag
> addition this cycle.

Oh I haven't noticed that, thanks!

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
