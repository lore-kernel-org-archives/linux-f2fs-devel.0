Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9933FC53200
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzlxMOCMtSuoToVCqrEz1dXL4BJV+ifAUeAYJN2VALY=; b=gruaPwNwt1NxVqhQ0K7d20z+xu
	c9GsO8PC/StQ52OPAhrltyfiU36hln0Vth8XDLqjzFQZuyh6G4GyqbNu/3AneTb2gQuvnYDgO6TvT
	0w4/h64nmoVMEXxIHv3eMGuqSnvIkZs301cjdV1mEF5YaGY3WNcLfXN+6hiqQSXkLtTQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp3GK-0003RX-Al;
	Wed, 29 Jul 2026 12:19:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wp3GE-0003RO-V4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:19:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X8aW2piz6HfaoySgXo89hRUSKILhJsvnQMKlUKJgl1E=; b=c7trNjsn3r6r1bpQVVF6QbHGpR
 9MW11AOAjA4VxQ89YihBe+qGHMWQNoXBsnlIFSxGSaMsizdS0DEcWKbnwZwwST5Hyf/OEm4HjmWqO
 20aRBz2g2GcbiRxfIEQ2/7ZyPCxrPphYvEXBNDOZOIXjok9BmptoOrPoB5CdcVEtPvOE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X8aW2piz6HfaoySgXo89hRUSKILhJsvnQMKlUKJgl1E=; b=CktGYxLC4OjWQtzG5kDLcfQKPY
 o0PJoI7TMRmJQONr1DTX3nm9FmsOE7ckHotrNck7CB3KFLnAeuNPTCHDil/GonC7SfNVzV4c1gZSB
 q/Pok7Jq9wteX5c1iu36VW8rmfLCzuyRaECW/OKS7GGbaYcW6gHDD72UuB6aq03bqtB0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp3GE-0005GD-Lj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:19:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC1A94180E;
 Wed, 29 Jul 2026 12:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF21F000E9;
 Wed, 29 Jul 2026 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785327577;
 bh=X8aW2piz6HfaoySgXo89hRUSKILhJsvnQMKlUKJgl1E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jXbh9GTEHEjjkvxiaUBqac+hEttpleeIIoSTjs7EWhz85b+lxhBUVNXEo1OMPRlnL
 RKBAKdxsdA8rMA3ONckHoyx5FKERb+qjHDWIETJss2PRoeQxKxaoRYA6aextM57OB7
 jJi2+IB9hvG0AtFhi4zy74SNCZ4I4vTZXRfz/NebCO6Xu7GjSCHd1LM5BjvcpCUOSn
 Y8E8VhDKitaehsekJ58ZIHp3jTvNSg7uDOGzNg0iotwjuo70zZAC1i1+uinL5GUNo9
 sKQz02cvb72fBrGlPV3e40qbu9eRoRIxeMLyVFpd9tsXi/6MXMV9WQemL9dKEG08mR
 9Hykm+WfCUFyg==
Message-ID: <022b437d-b1c9-4f62-aefc-a6d32ee6dbe3@kernel.org>
Date: Wed, 29 Jul 2026 20:19:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
 <20260724125847.3928772-4-yangyongpeng.storage@gmail.com>
Content-Language: en-US
In-Reply-To: <20260724125847.3928772-4-yangyongpeng.storage@gmail.com>
X-Headers-End: 1wp3GE-0005GD-Lj
Subject: Re: [f2fs-dev] [RFC PATCH v3 1/3] f2fs: introduce inline extent
 mapping for inode data blocks
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/24/26 20:58, Yongpeng Yang wrote:
>  fs/f2fs/Kconfig         |  18 +
>  fs/f2fs/Makefile        |   1 +
>  fs/f2fs/data.c          | 148 ++++++++-
>  fs/f2fs/dir.c           |   1 +
>  fs/f2fs/f2fs.h          |  44 ++-
>  fs/f2fs/file.c          |   1 +
>  fs/f2fs/iextent.c       | 712 ++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/iextent.h       | 163 +++++++++

Hmmm, the code size is still a problem, too complicated to support all
insertion, deletion, merging and splitting operations on inline extents.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
