Return-Path: <SRS0=BlV7=EI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A8C4742C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:10:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C9F22258
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UNK9G1G4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XBhirIca";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltfOBxu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C9F22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kZcPK-0005Px-Rd; Mon, 02 Nov 2020 16:10:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kZcPJ-0005Pa-Gx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Nov 2020 16:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aN9ADHWvHYLwcBMuPt2+V78hd3ut0nv6GGHOaLbZgZM=; b=UNK9G1G4JjefDKEHyQVKyJna1X
 8UBRGPv+OAFdV+v+fS9Jenw5KDRL0HLaot5fLGtFjpZ/I7K/2TZC2gb0+s/3fbtrPgovp/RkxxRoD
 mQyv8pp1v7XKFXHA5dum/uFpN1xhSzHnAo9jMPk4tgWrwxWyB+rAdkFdHQHGFn6ZJ6LE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aN9ADHWvHYLwcBMuPt2+V78hd3ut0nv6GGHOaLbZgZM=; b=XBhirIcazRVrCZ0hkE1DRcIfhc
 frnUxfD+tMzTtMdWg+PaMORCcXR1MNzuFimkannSHcOVNuX36hpa603rx19q8GetWevraDXStOP5A
 OHKI8tmkaHOx5k+esaPneik/WJOx5KIWe87JWt3bE6ApRvRI/kTXHLIdnpmxGIl1XIns=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kZcPE-006ZXZ-QA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Nov 2020 16:10:08 +0000
Received: from google.com (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFE7122277;
 Mon,  2 Nov 2020 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604333392;
 bh=KjbbvUyNRfIy/F798a/hF/fB5rEyDicNk6ioLYZH98g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ltfOBxu85u043HltVYcOv7N/cagykHReMo1d5xjIWgxmkAW1neFILugRAigchLKYy
 XiUB8T76w27vWSGkQocoKqm+sS/KJT7OONgPFxTkDLYgtxTujn+79cCnb3/KsPMmlm
 dg69SJDU8LH+QRkGaKC0rco7g0lSF+Sjj2BzdBiI=
Date: Mon, 2 Nov 2020 08:09:50 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20201102160950.GB529594@google.com>
References: <20201026094000.1500425-1-robinhsu@google.com>
 <299c9027-e137-83ff-b2ba-8af07144a488@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <299c9027-e137-83ff-b2ba-8af07144a488@huawei.com>
X-Headers-End: 1kZcPE-006ZXZ-QA
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs-toos:fsck.f2fs Fix bad return value
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/28, Chao Yu wrote:
> On 2020/10/26 17:40, Robin Hsu via Linux-f2fs-devel wrote:
> > 'ret' should not have been used here: otherwise, it would be wrongly used
> > as the error code and then be returned from main().
> > 
> > Signed-off-by: Robin Hsu <robinhsu@google.com>
> 
> BTW, how about changing 'ret = EXIT_ERR_CODE' to
> 'ret = FSCK_ERRORS_LEFT_UNCORRECTED', it's not critical though.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

I think it'd be good to go as is for now. :)

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
