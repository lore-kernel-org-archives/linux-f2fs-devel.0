Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74066C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jun 2022 04:24:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o4EOB-0005A0-Oi; Thu, 23 Jun 2022 04:24:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chaoliu719@gmail.com>) id 1o4EOA-00059u-OG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 04:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bekEvBrAwf7ehOt0TA5QrhCy5PmAltJgEblnufPH3EM=; b=HkHVi4PJI9TbQQGElZvC/JWctB
 jXFRf+Kyp3R7nQQJjAduxhzKQm8ilXVKwI3ieWmFt5eCwhKjXkOP6ZAPXNwJ6vhkTx0JEyHWHm9Qb
 pk5WicAYPO3PuvwXuM6wyBWvCUWPx2cQP7FuPqPNHdXgdAE5i8oavvdu9NyTzPVnTbpc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bekEvBrAwf7ehOt0TA5QrhCy5PmAltJgEblnufPH3EM=; b=hNVMuOc0+y3wZ1ri6bjMn67DZU
 gZqrlbXtJeHi5IpZRumDUlfJ9VV2DE92+2cZK9d/Kv82kMF+Rm9ZLwl5SPfjmDWTbQxFCuBWp0zf8
 7nMyAuecF+RvFaZJs5KYBJidviEwPm/PQGytaF9GgMd0/7z0OEThEnKe34hcCFu72xEA=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o4EO7-00AqA7-A6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 04:24:18 +0000
Received: by mail-pj1-f41.google.com with SMTP id p5so11930354pjt.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jun 2022 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bekEvBrAwf7ehOt0TA5QrhCy5PmAltJgEblnufPH3EM=;
 b=KdK//VDD6kx3P/ZIaXk4K6S5ZpICov0tsGYyxei43BtZQKnuyDJxSU0cnYIifkHFzx
 BKXti9irzZRt0NTnpWEneOktfgc8vg/c3JJzUGg7NpkTgfzaJ6bRsm+hcjjCpGvZM217
 WcZtWX5NY2NHXn57moxaN6df9Vhca/gICgKM6qIuBIsV2Yyb9xLKBo6xywFHxXJD9JsI
 k3FFGu6LdvBM73ckEccNe8IZazkeuCpi24N5NTCpR88xbY5xGQkcU1D2VQTqYi6jjeMg
 7cZHzaShitlKiM/kpo1E0QJeknFfXoBBZd/knDBKCknfmaogY8RCJms/gwAAbKuaVB8r
 bbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bekEvBrAwf7ehOt0TA5QrhCy5PmAltJgEblnufPH3EM=;
 b=7iTnTUXvJ8tBri8U5RtHXxZHVDYpydRzJuC0cJLmFByxGgHacEjAa6FqQ2LgqndtWZ
 jHN+hScSIck8S9egUuV7v8xDcH48Fd0I0U/1YuzDUuJdHoDPqBQUE2Hyo5umjyaOCLaS
 bkCeVpI9sbHoerweQ7HdU3BS39WDLWRTppYy7W15pEr+ydK34gIaj5Z45Z3YyMC5AxIk
 nUBSNj3C2WNV2Txfexskcw4tZtN1mYjb6gMBtaSjEarrXRcMPKppJBFhiyBtqer+c84J
 6zHZnNNY2L8ZSOsUy5+lmwsu2DadT5uQDkyK/JIfuTQwSqIo+YiXsdfb7ap0niXCJiGH
 v+lQ==
X-Gm-Message-State: AJIora/vPqyl/bnvhXMses9eiLUzzIxpgh1G912afUbPExygpIBfiGXa
 laeSVxIH5GqmA9mmXbfuBQo=
X-Google-Smtp-Source: AGRyM1vsLWvBZGegv7wcX1GkV0vLTjBiqD54awG+CV1o5P+AD5DBf2qnKRGasNxwEIhUWq2/zkNtgA==
X-Received: by 2002:a17:903:2585:b0:16a:3c86:c76b with SMTP id
 jb5-20020a170903258500b0016a3c86c76bmr10134891plb.88.1655958249566; 
 Wed, 22 Jun 2022 21:24:09 -0700 (PDT)
Received: from liuchao-VM ([156.236.96.165]) by smtp.gmail.com with ESMTPSA id
 jb11-20020a170903258b00b0016a18ee30b5sm8208734plb.293.2022.06.22.21.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 21:24:08 -0700 (PDT)
Date: Thu, 23 Jun 2022 12:24:04 +0800
From: Chao Liu <chaoliu719@gmail.com>
To: Chao Yu <chao@kernel.org>
Message-ID: <YrPq5N61W9vFGTub@liuchao-VM>
References: <20220621064202.1078536-1-chaoliu719@gmail.com>
 <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7fb689d9-11ba-a173-8ad4-a328a03298a8@kernel.org>
X-Headers-End: 1o4EO7-00AqA7-A6
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow compression of files without
 blocks
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
Cc: Chao Liu <liuchao@coolpad.com>, linux-kernel@vger.kernel.org,
 Wayne Zhang <zhangwen@coolpad.com>, Yue Hu <huyue2@coolpad.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 22, 2022 at 08:50:33PM +0800, Chao Yu wrote:
> On 2022/6/21 14:42, Chao Liu wrote:
> > From: Chao Liu <liuchao@coolpad.com>
> >
> > Files created by truncate have a size but no blocks, so
>
> I didn't get it, how can we create file by truncation...

I'm sorry I didn't make it clear. We can create a file
by passing a FILE parameter that does not exist
to the user command truncate(1) [1].

How about using truncate(1) instead of truncate
in the description of the change?

Thanks,

[1] truncate(1): https://man7.org/linux/man-pages/man1/truncate.1.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
