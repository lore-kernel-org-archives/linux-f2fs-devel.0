Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B12C44512
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/mGP+AMdvcWhBH4JS4Ro8IuJ7I0ijEbazVVSAVrESI=; b=QGFoEsDp5XHWFj677x/FvGrNbP
	9y+xtZwpDQvUG/akcfaXxTg/CxMOrqXzWEBTADsE87pDvo84M82LTLngmLm56Qf272FJAYuOALYkv
	+ya9ZTFtFkYpfKmVTw941GOF+vxIM8Jw2AT7hE/tlipQ4pXHb7q0zp8LLLbRR/SlblRM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlNlg-0002FV-8S;
	Sun, 19 Jul 2026 09:25:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wlNle-0002FP-9d
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 09:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hlcFkYOTVjgj40EJYE2FLarQkNMyiNL2f8HWPLYDJMg=; b=ZWAVjOz+rjSjuWCHSeFaliUKwT
 ueYSykYhomoAkw0PfjxLBeGFJ2Vp2osQ7Pzd0tmdPwsPRqyfTXFRjMVcJixqvoZaVjlmm9gYXz35w
 aAiwkxz4mgdsF2eCO8c9Rw0i5uI2nGxvb9ZBw69tFTIuWumc9TQPD3xVSHo+TjVn057E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hlcFkYOTVjgj40EJYE2FLarQkNMyiNL2f8HWPLYDJMg=; b=VtGEMpe8nNSxmwXt4WgmOjAiqQ
 sA1EI88pJOjVFMXzxshNNzzpzswo7TTVIsdLmV9CKcxx6yEBZeeMVGGPQHbO7+XmiYfsqRzxoFiWp
 QjjuWl4AMRtY/x2YAracW3p5W5EdG9dgYvUPzXh6t1f1/RagLK6rQct6YQ+EQXfnr+/c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlNld-0005NH-4i for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 09:25:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76DE66004E;
 Sun, 19 Jul 2026 09:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1926E1F000E9;
 Sun, 19 Jul 2026 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784453095;
 bh=hlcFkYOTVjgj40EJYE2FLarQkNMyiNL2f8HWPLYDJMg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K99RGjD/nSQfF9NCIJd3xX3vHo7jXLmrcabEIWyknnuTAFkjysjXG7d83Qeiwpw31
 iENrDt5uFoDhlRzBcw3iKhTHIU377vTFt+5YoKpUidvvwUXBiif9IKxZEtzHunxd69
 HZtmrP2xLFM0dNkXxlDkrWCGEIsbawGMObD836YUqskCMEP/PLtaaA7eqdTZeNFJcn
 QL7Xtr2PomXpCHoe06E2+znYWHXhwa3TrCULJ4iafgwBQ1qljgfESdnzmsJ5U9YQWK
 CGuLUE/Qadyq5dR5StVMgftyzgOs30BmNlxMG35wGDWlZoMuktVelANaIPWQzOFkJc
 GslivruuomQbA==
Date: Sun, 19 Jul 2026 17:24:45 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <alyS3PRtALHIV5no@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>,
 Jan Prusakowski <jprusakowski@google.com>, 
 linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org,
 jaegeuk@kernel.org
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
X-Headers-End: 1wlNld-0005NH-4i
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, jaegeuk@kernel.org,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 30, 2026 at 08:09:19PM +0800, Chao Yu wrote:
> On 6/30/26 00:37, Zorro Lang via Linux-f2fs-devel wrote:
> > On Wed, Jun 24, 2026 at 12:46:01AM -0700, Christoph Hellwig wrote:
> >> This sounds odd.  The test allocates a contigous range and then just does
> >> insert/collapse on it, which should not lead to any new data block
> >> allocations.  Given that the test works fine on zoned XFS and btrfs
> >> with strict out of place write policies we know it does not require
> >> overwriting blocks to work as well.
> >>
> >> So I think something is fishy in f2fs if needs to allocate data blocks
> >> here.
> > 
> > I have the same question with Christoph. Shouldn't fcollapse in F2FS just
> > remap the metadata instead of allocating new data blocks?
> 
> Hi Christoph, Zorro,
> 
> Let me explain it briefly, this is because f2fs has only one copy of reverse
> mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
> directly during remap, otherwise, after sudden power-cut, we will suffer
> inconsistent issue in between reverse mapping table and mapping table. So, f2fs
> choose to rewrite for any checkpointed data.

Hi Chao,

Thank you for the detailed explanation. I now see why F2FS handles this
differently.

Since this is by design for F2FS, I'd like to merge this fix to help f2fs
avoid this test failure at first. As for the potential write amplification
and performance overhead introduced by this rewrite strategy, that can be
discussed further on the f2fs list if necessary.

I will merge the patch with some clarifying comments:

/*
 * F2FS uses a rewrite strategy for fcollapse/finsert on checkpointed data.
 * Since F2FS has only a single copy of the reverse mapping table (SSA),
 * directly remapping checkpointed metadata could cause inconsistency
 * issues after a sudden power-cut.
 */

Is this ^^ good to you, or feel free to give me a proper comment to add into
this patch.

Thanks,
Zorro

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
