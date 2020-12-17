Return-Path: <SRS0=2T6g=FV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E93C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Dec 2020 07:38:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDBB22D05;
	Thu, 17 Dec 2020 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDBB22D05
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1bf1tGdZ0+CiMB2t3+MNgUhVpo7BVS7OQr0NQXvXxk8=; b=OSLmZPvhB2YoisuM7dL9co6dB
	OaJcJ46+R6q6L+kcdumIo0JIxvUB3Yrj7IFdT1ThD1GTv7+tb9nb2mD9gyy4dSiPkz95Y5A8ADs09
	E9dRuFZ0osai93D2Ck3Kv1LlpCJiCN8FW21v86aHaWDnJg6D1/W/qYaiFado0n7CxzQlw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kpnrm-0007q6-Hr; Thu, 17 Dec 2020 07:38:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <john+kernel+f2fs-devel@zlima12.com>)
 id 1kpnrm-0007px-6z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 07:38:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oWQJwdNoHAvcru9tAYG9OUMBhDf5XVfXUnca0SLMN1c=; b=YSI4Xu5QiYDVV+V+3pWVOaLgXl
 N5DPujHqEX63NW4vhY66fJUTv3R7wW9QKpT30Ly8BDvY6YmvBzwIRVmZWRLBYiGw+FshX3ANYxc4E
 JOuJJu46MDcfNxr6gGJ0pZVaiJZHJ1HW8mBio88SY4TK/JSw7dxzSATRks5RXecCBdfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oWQJwdNoHAvcru9tAYG9OUMBhDf5XVfXUnca0SLMN1c=; b=SxbGhXPcdUhTn78ZLG4YpBlahv
 Hkk8sKxegKT1igxO/WUtc2rdW9mcSH/pRL0K4zY6AjRmPt/6URXSVKJtjPNtUUNLVxHQAdcBKpNFv
 9SMx8Z4VufkgGDZBLiU+/v9jiZPLVsMSP45UZE4+gLV5Zpe8nBNipZlfL/u7i+yFXUKE=;
Received: from smtp.zlima12.com ([107.172.191.159])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kpnra-00HNYX-1o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Dec 2020 07:38:26 +0000
Date: Thu, 17 Dec 2020 02:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zlima12.com; s=dkim;
 t=1608190672; bh=YzwXHrSl+eQgTJ6dfNthQ64GzMOHWDV1AqIfoTZn87o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=S4XF19j49Z2DrqRJw2biLPlZOv1rcGDCogM2yPzPCVuM00NrbdMMz/npZBq+/4mPq
 0LyEzyIQ2Y1t4fi+PrWagvLoZaNKunxBgFqFELVOWPiwc+87A4Vak7oRcvesjWnj+D
 PoE3BQIatDSt+XL90P+qIFb2wZ8dRpnk1O4bA0Efty87Xln/USn6Us2rco4GXj8nOp
 JM2k34KjvAH+WkM8lMxJ2qiGg4I8tiBUTHax8I4iHFbGBNptEBhvcEsOZG/ugXMKWh
 iMQXUG7G/8YF71yMAAlO896AEWF7EYewfvHR8rZrm7QmdWfg84laOMDiytEA+yrTN9
 UqExRgFhqSWpg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20201217073537.edgy5eafcespsonb@Lima-1>
References: <20201215015800.u37ixmukkwihmxi2@Lima-1.maple.zlima12.com>
 <X9r6LjHCmeYv42nS@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X9r6LjHCmeYv42nS@google.com>
X-Headers-End: 1kpnra-00HNYX-1o
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: Fix behavior of -g option to
 match the man page.
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
From: "John A. Leuenhagen via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "John A. Leuenhagen" <john+kernel+f2fs-devel@zlima12.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Dec 16, 2020 at 10:26:54PM -0800, Jaegeuk Kim wrote:
> Hi,
> 
> On 12/14, John A. Leuenhagen via Linux-f2fs-devel wrote:
> > The man page states that simply specifying the -g option will use the
> > default Android options. However, mkfs.f2fs currently requires the user
> > to specify `-g android`. This makes the behavior of mkfs.f2fs match the
> > man page.
> 
> I think we need to fix the manpage, since this requires to change all the
> use cases in android. :(
I figured this would be an issue. I'll submit a patch for fixing the
man page.
> 
> Thanks,
> 
> > 
> > Signed-off-by: John A. Leuenhagen <john@zlima12.com>
> > ---
> >  mkfs/f2fs_format_main.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> > index 03eb748..8db2191 100644
> > --- a/mkfs/f2fs_format_main.c
> > +++ b/mkfs/f2fs_format_main.c
> > @@ -129,7 +129,7 @@ static void add_default_options(void)
> >  
> >  static void f2fs_parse_options(int argc, char *argv[])
> >  {
> > -	static const char *option_string = "qa:c:C:d:e:E:g:hil:mo:O:rR:s:S:z:t:T:U:Vfw:";
> > +	static const char *option_string = "qa:c:C:d:e:E:ghil:mo:O:rR:s:S:z:t:T:U:Vfw:";
> >  	static const struct option long_opts[] = {
> >  		{ .name = "help", .has_arg = 0, .flag = NULL, .val = 'h' },
> >  		{ .name = NULL, .has_arg = 0, .flag = NULL, .val = 0 }
> > @@ -169,8 +169,7 @@ static void f2fs_parse_options(int argc, char *argv[])
> >  			c.extension_list[1] = strdup(optarg);
> >  			break;
> >  		case 'g':
> > -			if (!strcmp(optarg, "android"))
> > -				c.defset = CONF_ANDROID;
> > +			c.defset = CONF_ANDROID;
> >  			break;
> >  		case 'h':
> >  			mkfs_usage();
> > -- 
> > 2.26.2
> > 
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
