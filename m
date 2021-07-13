Return-Path: <SRS0=igo+=MF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE9C07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jul 2021 23:45:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3D060C3E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jul 2021 23:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3D060C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m3S5E-0003Op-HB; Tue, 13 Jul 2021 23:45:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1m3S5C-0003Oi-LV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Jul 2021 23:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uiBX0RjXZJebGpM5ntsU1l99GVTwVhL86Gn7u/V3aOU=; b=FfHjrdZ08zU++GDwFbS2amSjUj
 YP8IFY1UfoGPBQi0qM76uvZ9IgZh8+ckePsNsVJvKVrCkN7qI5OjETkePzwq0xpxc0ne/Yo3G9O4d
 Meeo7ifacH4RlOhZ+qIEM3aOy0xQyynn1YuO9/hWDREzFLaZZ48xCbt0fCKCJA56shx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uiBX0RjXZJebGpM5ntsU1l99GVTwVhL86Gn7u/V3aOU=; b=HnYvqAzVE8rqWbuJBBUKTA4qab
 1TKUZWIEba7jSVXDKN6M+xXRV08gXVwx+U3Sd8HV4kVCoQ/WSs7rrAIptumBJZ8byKOEggcRir/Di
 MuvbdKvae0iECamYgk7qixieE/Iv3epce+V62XQlHUYd1YMER+VAxcXQQMrjl2R3iMfc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m3S54-0002lr-St
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Jul 2021 23:44:58 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8ACA2611AC;
 Tue, 13 Jul 2021 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626219880;
 bh=AMYbCZgVGjVDjgAwIbxo4i9kw7wOkMMjWAO/lrYzU/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m7P6v73QKIiI9gNzQ9wRtx+0lHVsvXSZCbPq0AHjjDpXJRkwtl42MayWmXiCSqCYT
 qoabGd8IjMoj4jSHJb3ltJY+Dk4WY11/kuSkxUmRcUq2LWfdDR7pakRTXA+IJ4EcSa
 u7DIqilLoDxJrkAtHYf9ImE2uwrLOWBuU3L6ad6EMVb8ErXBM2ka413Tdkn+nwoCjZ
 ihlLssKgXWkVILeCWZ3TXV/YO/QZTq4N5Y/OaoBY+eBaap7LuMi5lrkeQh4xpmkQ03
 c0hTxYSbEXrFHJZBiTz7wqfzMW/TKsUS7SGT2IijluNryEFq+SzOERsJCT+0TnOukz
 vjufEoVJgNfhA==
Date: Tue, 13 Jul 2021 16:44:39 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YO4lZxIH772ms1wB@google.com>
References: <20210622115059.24860-1-changfengnan@vivo.com>
 <7e7d1dec-d245-8451-7a08-20c0c937c21b@vivo.com>
 <73528afe-8331-85af-48c1-f9d733ed8e39@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73528afe-8331-85af-48c1-f9d733ed8e39@kernel.org>
X-Headers-End: 1m3S54-0002lr-St
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: remove unneeded read when
 rewrite whole cluster
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/13, Chao Yu wrote:
> On 2021/7/13 10:35, Fengnan Chang wrote:
> > Hi Jaegeuk:
> > 	Any comments about this version?
> > 
> > On 2021/6/22 19:50, Fengnan Chang wrote:
> > > when we overwrite the whole page in cluster, we don't need read original
> > > data before write, because after write_end(), writepages() can help to
> > > load left data in that cluster.
> 
> Jaegeuk,
> 
> Let's queue this in dev-test for testing?

A bit worry about unknown corner cases tho, Chao, could you please test
as well?

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
