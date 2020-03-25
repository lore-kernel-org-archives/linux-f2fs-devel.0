Return-Path: <SRS0=re5T=5K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA38C1975A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:21:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C7E206F8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fRoPNT7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bmKbR96I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="uicKA8wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C7E206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jH8mb-0001nT-Hw; Wed, 25 Mar 2020 16:21:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sergei.shtylyov@cogentembedded.com>)
 id 1jH8ma-0001nE-3c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Mar 2020 16:21:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FFKgDeHvhTCS00AQN8L5xpmPeeM6E1oKLK7azqnWDiE=; b=fRoPNT7DnLPZXEI8brfz7a9Iy2
 Rfa27a7QAD7I/qfgMAsQfAy5JkIff5B4rVyiUAmg9hE8AR2zm9Y4zpwsUYf5xyd6YxBitaSUe+/G0
 zYhT7Lb/6jqC1guBRq4gc2YnJAO22+jG31LzKZco19EXrQoHZ0V249tfGVVGlHkGab/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FFKgDeHvhTCS00AQN8L5xpmPeeM6E1oKLK7azqnWDiE=; b=bmKbR96IQgh/l4G0Zsnt4IKpPD
 7PyB6FYfH0JRV2CVik2ozK3oCRvomMeOi+fvO/bCa+TzGykqBUo9QbbJ4XI481ISCEe1C6p39wN7V
 JV9UNi50shBjMLlKgDpS/YaucnYilbDrf9SfZ1wvNWgeUgEEc/EG3sdVfTkrSRXuDTzw=;
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jH8mY-006tBO-5C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Mar 2020 16:21:32 +0000
Received: by mail-lj1-f193.google.com with SMTP id 19so3104369ljj.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Mar 2020 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FFKgDeHvhTCS00AQN8L5xpmPeeM6E1oKLK7azqnWDiE=;
 b=uicKA8wIvWFlXoj/N3LEYBm1C4A3V4P9iw9tec/gYSHrhStzUBQCHg9572Xte1kjgR
 ThMBTvZUPKiWKz7FpDL5FpZdKIk2YCmk4xT9mv8vXzDYbG7BnewAeqmTmjbMblvWal3H
 mWL8hgD8rxlqA3cc+cD7G6ybnkogU1aJ7AGejI0PI8JR5OHaQ8Yinse9H4h+GK2Hb1A4
 AO25iODgSANaemv90W5sSFYFQjzOpxBoKLIe96Vf8WjB/zrqJX1NEJY7yq750pQkaqOk
 1+9OYeGLNZxl0e6F3esYfat8n9CQbuKfwTbzDvu3Chf0eeKLqiEo59Jx1mNdOEbnZcqK
 7RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FFKgDeHvhTCS00AQN8L5xpmPeeM6E1oKLK7azqnWDiE=;
 b=PgU4/yX3x0lSh9gXaOESR3h2TWNADcv8u7WP7ONX2n5DCoj3GZ3lpV3qt3/dElcDAD
 HIKSM/R0zBfJo8ruTwoTI29M/7qhc/wW7GzdDpgxu+mrDtJjgZPsz/laWJfZX6Eha4yk
 9+ZFs25mbofbUoMfs4cunEhybdzUutmn0LkCebj9cKr3noz1xV0yHDTDHVBQRXiQ3Tlf
 i8atEb/P92+metF0QRR2rksca4PybeGYQT3BArnSI5rJGAG/J0fVTw+97ynh3WOyupzX
 097iKffZlfZdCYGMD+J93SKvGLh06S57DTMzGAfVdz6hvtHvqF9oynHytT5dgg9ZG4Ff
 gCxw==
X-Gm-Message-State: AGi0PubZoaEE/yIVaxxvlGCgoHsaMT+qxR8w20C9jQxzo2xmqC5tj7kt
 YX5cvMwpoGzGGcXd0MO7VeudWa8/9aQ=
X-Google-Smtp-Source: ADFU+vv75ZUwXg2vEi4sa3vjU/XvBmaxBeQGnk0gRxgFefclx3FSltiYeD1SYorsoysNlfqIA2nFcA==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr2510095ljh.44.1585151522265; 
 Wed, 25 Mar 2020 08:52:02 -0700 (PDT)
Received: from wasted.cogentembedded.com
 ([2a00:1fa0:4678:2dac:733f:487d:7a84:7bac])
 by smtp.gmail.com with ESMTPSA id l21sm275175lfh.63.2020.03.25.08.52.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2020 08:52:01 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard@nod.at>,
 linux-xfs@vger.kernel.org
References: <20200325122825.1086872-1-hch@lst.de>
 <20200325122825.1086872-2-hch@lst.de>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3771d2fd-b563-b74d-491b-e2bab9242126@cogentembedded.com>
Date: Wed, 25 Mar 2020 18:51:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200325122825.1086872-2-hch@lst.de>
Content-Language: en-MW
X-Headers-End: 1jH8mY-006tBO-5C
Subject: Re: [f2fs-dev] [PATCH 1/4] ubifs: remove broken lazytime support
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello!

On 03/25/2020 03:28 PM, Christoph Hellwig wrote:

> When "ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs" introduces atime
> support to ubifs, it also lazytime support, but that support is
                           ^ includes?

> terminally broken, as it causes mark_inode_dirty_sync to be called from
> __writeback_single_inode, which will then trigger the locking assert
> in ubifs_dirty_inode.  Just remove this broken support for now, it can
> be readded later, especially as some infrastructure changes should
> make that easier soon.
> 
> Fixes: 8c1c5f263833 ("ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
