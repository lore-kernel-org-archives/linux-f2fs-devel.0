Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616DF1076372
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0LHgJGnO7hpnwCFqWjZTH8sfT9StWTjTfOO69oVmQGQ=; b=SpspOdx0qaCBMlAqWEmanv+eqZ
	SjcqttWh2XPfcbg/guFuC2YhzkHszo9+qNShOnbiEfuqeSzTFSEw7O1nm/tvhXqZus09bqPuhxi4x
	QGj8KmQZn43wh7EWBKnkHGy8MrHp6voDpt/bJBYOxIZ9rwJZO35RyAk0aqwnca8eU850=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7p7M-00083p-PJ;
	Wed, 01 Apr 2026 06:31:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w7p7K-00083i-W7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FmG9+oEc3u0Io3xHytit6dYoUo70py6nf+qvoLgQLuc=; b=eR1+DK1FvjdTub0f8hI8XIhClP
 b8HVFkmYbQW+jTaC07Q6jFf5d8BLhh7jABiCGjwJQJFOfFAXSqHgBIprBpD9hmkQJcGiEtZOQK6dP
 zwGzEB55AJ9CtgxWFU7H0DNxLRngDZfSWvk2BXYJzGJ+6lSctHxflZO1gTy7TjAEOAO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FmG9+oEc3u0Io3xHytit6dYoUo70py6nf+qvoLgQLuc=; b=KywzfzzmQY/+kpBQrkl2HHZJJJ
 PEqiw2jh94etPDokY3j//J08lZTTRAe/Xt+1ELxw7x4borbyJLT+CpYTRajU98PMFC0oJd3LBF8zY
 MlQGHtvz15FQlRjPXupCP5qjAXzWs5gftYffUDKOx495aQ3CX/aoYnyNKvu0uNGzMVFc=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7p7K-0000lU-HI for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 06:31:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 56EA368AFE; Wed,  1 Apr 2026 08:31:47 +0200 (CEST)
Date: Wed, 1 Apr 2026 08:31:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401063146.GD24459@lst.de>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-22-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-22-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w7p7K-0000lU-HI
Subject: Re: [f2fs-dev] [PATCH v6 21/22] xfs: add fsverity traces
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Wouldn't most of these trace points make more sense in the core
fsverity code before calling into the file system?

Otherwise they look good to me.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
