Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D122CCD5BC9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 03:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cxg2VcgxaEyvvESFrtGIRrOOmbLhLgOuKb95ByMaBfc=; b=ab6eKIQHwydlj1NofiZri3LCZq
	ZDCUfCujijIVrOaoZUlxEqbD4OI8Wr+oebTUgjEQqNsDPc9DF+Xfy3HRJ/8fiNqxnPeIuh2vtAPsZ
	NzZug3dNsgkTAtFOxvelV2dHxCiPFI6TajQFt5h73BD20DZyGMjh4sUpT0ZdQ4BE11Ro=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRiYk-0006oD-2y;
	Tue, 26 May 2026 03:34:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wRiYi-0006o7-Ic
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 03:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzxIDQSSkfJgeOWIE/b/66yps/8QKZUf6btX6QP9PLs=; b=AjbLTneLi6SJ1/MWQ0qLYLDcQ6
 sPhMaCErkdBt1tzzjbwV7KJ1sQAu4so+fVJgMmo0SD/DJPfYPCFkNfzPYCKVxb76onuAuxtmt3ZH2
 nS8qmdLDddS7cjp59g1zUjY0uIq1Dwqw1PjNetgswUGly1EWE6PV5oIp6OVeO8YL2dNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kzxIDQSSkfJgeOWIE/b/66yps/8QKZUf6btX6QP9PLs=; b=DMHp8SAybryaa/Jm3LSYCdWMsN
 VNZ2HpZbBtW43RyWxFh9hXakNWrvnYXoRu4mFiESqHZYmifB5Mn132ewJ9DiFol969HDetyuD3zi1
 fMi9GTxqYW8nLqTA9lWbeV+/910EZujwZpDeod0mr39ZOy2o0nSPCCyUGtmlyWQ5lJr8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRiYf-0006ao-03 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 03:34:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03A744013A;
 Tue, 26 May 2026 03:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D83A1F000E9;
 Tue, 26 May 2026 03:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779766450;
 bh=kzxIDQSSkfJgeOWIE/b/66yps/8QKZUf6btX6QP9PLs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ox+6z2Bbjg3Ky/+rp0Bm1D+6MC26KlSfeMtVH9uQjXCZSGA9a5fpcM5Le8m82mWEI
 2Ww0aMuvq88M/TosuQf9mS6uLWIUceeIN+DjUZFT56jeT2NHNjY9jp3E3LCHVoMgtt
 rkmSLKjwU5fGSkFJm8xHevnqNl0DaAMktd1/efGifsG2Qe9RgF735AFBuqjJOxIsHv
 5eUXkfiRT319JXGDS0KRGF/oHdzCvyZ/LJNwS9BLfKd4k2vHiKdFMmfRp/Npm4UzMW
 crbIBM8hJO6QnAZTfWdtC8jZxzEBkVtJ6X/fk+sW6mle9oBXOPjE6ZGtjTZMW5Y72O
 cZ8DmHAeH8sDw==
Date: Tue, 26 May 2026 03:34:09 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ahUUsXZS6FN7dr3M@google.com>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ahUG3ZCnc1RQ0EL_@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahUG3ZCnc1RQ0EL_@casper.infradead.org>
X-Headers-End: 1wRiYf-0006ao-03
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/26, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> > Let me try to write more details, helped with Gemini.
> 
> This is garbage, and frankly disrespectful.  I'm not going to argue with
> your AI bot.

I wrote down all and they rephrased it a bit. Which points are you feeling
like that?

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
