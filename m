Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DD3EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Jul 2023 11:19:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qJuMR-0005Ds-T9;
	Thu, 13 Jul 2023 11:19:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1qJuMP-0005Dl-G6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Jul 2023 11:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Id3dDSEZ8ejwio8FiH8f9/mFmdYUyuGbpNTIxJPoZmo=; b=R2ya4SnK8kXq4uzn52q9JfJnGe
 OOySsfO2J/2LaTkFNt0kwOFY6o6hHyYFiKHpNkIsxM+fM31Tns0y3r7tw3xImzTwi3Mvknxi5G7Sh
 gdLY0UN7VhGLJfjUS8qCcjUadGdsFnH1ojudcwzJGbPMzl9sztzE5XOVC5ARVwWB/+sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Id3dDSEZ8ejwio8FiH8f9/mFmdYUyuGbpNTIxJPoZmo=; b=c4NlSrXqOQ17+tn2gXMWTnc2zP
 47lvRa65bdvwvrec8OM/9WP/9DICgsYunf5Grh1yp2QC/t6AYJcbsl50emLkVZdOBpxHhCl48Y96+
 gsGVHTeoeDa4ifDqgPiDUtCVZMLGAvjsd16MAQdvDJ+0DVbqEVpT8HALTdqlXdA7rHKs=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qJuMP-0002Nr-02 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Jul 2023 11:19:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C7E96732D; Thu, 13 Jul 2023 13:19:36 +0200 (CEST)
Date: Thu, 13 Jul 2023 13:19:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Message-ID: <20230713111935.GA22470@lst.de>
References: <5ncdtsl3nycvxwldjg27yhqbt3pg6sdnjlynucbt536fudq7pg@o4zhoxt224jm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ncdtsl3nycvxwldjg27yhqbt3pg6sdnjlynucbt536fudq7pg@o4zhoxt224jm>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1qJuMP-0002Nr-02
Subject: Re: [f2fs-dev] [bug report] f2fs mount failure on zoned block
 devices
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Take a look at the "f2fs: don't reopen the main block device in
f2fs_scan_devices" thread on the block list.  The first version of patch
still had issues, but there is an updated on deeper in the thread.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
