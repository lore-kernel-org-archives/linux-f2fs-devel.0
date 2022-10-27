Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341EFA3740
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Oct 2022 17:30:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oo6hy-0003xt-8G;
	Thu, 27 Oct 2022 17:30:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1oo6hi-0003xg-Rq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 17:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ANNxtBdY9kDyFrpJGg4FqjKDVseHCFX+gNM0588+trU=; b=AZQwPO1KguJ43qQq6P3d2kQ7/Z
 sbYOu/mAYhKz+rkquLRDZ9RH7zkx9ICZW3HdiUoO6WADzfnKNRqCx65mzmYsviSUVz4Zb1CSeM1/O
 Bk8o0Uj7l8H67+3s4e2o0sYbVNnjy4aagdtbF2E9pq3lAlSB+bRSgeXNHAfqbh5NEoro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ANNxtBdY9kDyFrpJGg4FqjKDVseHCFX+gNM0588+trU=; b=Wj8ElrLvy4MeakNPPMjqYNngsY
 98ixj0CJqGfhy1xWtoODUDYkcWwBUih6fmR3JxgflZycRV0A21I3yOvU/mJc404omoHQRHj2J7o5Z
 zQ4gQuUNdQt9aVVeZ2iLfrEG5arDorLyXRbgQaQ5/0R7QRVP2wYGkcCiu4qx4FjGjAaA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oo6hg-002EEN-U8 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 17:30:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D2237B825F3;
 Thu, 27 Oct 2022 17:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD3BC433D6;
 Thu, 27 Oct 2022 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666891792;
 bh=AGsC0hjTQr8VlagabTIS0/mrR7vHEhqZGJ5Iuwauy0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kAxYN5zuqnatKL6hbYPimiFFMnN3t1QEhBFfjLa5sDzmjRPNBH3ugEVTAp8FDAlJh
 1H0SdjqZLVFC0ZE9Q9lZbeWwi+2Hc7gMOuOJm6lbCUcJD45NSXLGOp+Jjs0UtZ1HOR
 4mGYn9+NFbFxzMs58DTTv3QMQRl0goZY516D9gcw60HcnhuOgO+8V7EnzJQIjJkHA1
 Yhwd7bHCyfMo7l3cIpoC5C+eVYDV2EayJVQ1g25fCMMwrO66pUUhBgSdxTmgZUFvwM
 bH33bchDuk5n1gacRca72wf21n4oqs39kLrDwyVUZmTrmKVrhyPMj0RNdbNdTaYy3F
 hw+zW4WSbDw7g==
Date: Thu, 27 Oct 2022 10:29:50 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y1rADqN9gFjfL/AX@google.com>
References: <20221027102447.75708-1-frank.li@vivo.com>
 <20221027102447.75708-2-frank.li@vivo.com>
 <db6d8470-47f5-39e4-a692-efdc16603144@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <db6d8470-47f5-39e4-a692-efdc16603144@kernel.org>
X-Headers-End: 1oo6hg-002EEN-U8
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix return val in
 f2fs_start_ckpt_thread()
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I integrated two patches into single one. I think we don't need Fixes.

On 10/27, Chao Yu wrote:
> On 2022/10/27 18:24, Yangtao Li wrote:
> > Return PTR_ERR(cprc->f2fs_issue_ckpt) instead of -ENOMEM;
> > 
> 
> Fixes line?
> 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
