Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE532CA5FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eqn9cuNKl2d2tGJ0+ogAdj8HjFpgKMpt3EiXhUEobMk=; b=A+nJQQswdoe1pOlnyeEGQk6y0G
	sio2qTOPPIRVXOEdoYQk/uQVscsUTxh/WASsuS23GJ+/JgICeqZr5zb7QvS5FkHadBZseYy3c4U2E
	FM3Zl0hLaOm3YBshSmHQbkOH7aljwNxZL09meG2guWmAdYw79V2j+oFkja2N1wIeqVLw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDkZT-0006OH-3S;
	Mon, 05 Oct 2026 15:25:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1xDkZR-0006O5-MF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 15:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Baen8PQryX8eDiBxdXY1HWpb+ZNaxbRwgEV7WU05tqU=; b=Uk6Fh7HE1jhquAOEJNmD2xHZa5
 /FSpUYgxjc1e5UWDs91FOO3PS4jSGOZSkWvk5l+njqLK28DWhMcUtxg/EQgmLv7Ot55SC3xForLzj
 +4cGHnxueDufw1wUc2rH95DZ/al53eDYggrzot+EpHv7RWg4NsyTTS9H5OQmUm6RQXes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Baen8PQryX8eDiBxdXY1HWpb+ZNaxbRwgEV7WU05tqU=; b=cHPcu9urzoHj9xI0PZkqDkOx+5
 h7814roYWmt/s6yM3bqEXUKb1Wbxs3phyzE/1WuQK5bs776lr1N4W+h7r8coG68uRa/R9Oc17pLF7
 TeOeQx94JJR6cdfLZ6e/xuOqOHtMMYC0qTnzKUz2OcQ96ckasUiTmY2nG+GBCox2jsgs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDkZR-0002Ux-Sf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 15:25:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FE9460514;
 Mon,  5 Oct 2026 15:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47881F000FF;
 Mon,  5 Oct 2026 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791213936;
 bh=Baen8PQryX8eDiBxdXY1HWpb+ZNaxbRwgEV7WU05tqU=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=ID6twCZ23CBIvdE9pAjZ6ib+JeVI5jvnlRg29iEXhzywXTUzKtDVFgBUtQL+uMMMd
 zwDMldBFSZTvuvlhXH/4KdBf7ivwpSbS7U/d//6j9OWsYDgmmXxOdTjXpFUwI9HcM+
 hcgyYhMOkhbZ++sRytWl1FVOBw7DFC/Bbb3isWxfwipLerjc0r7sktNWPTo5hll9jv
 UVa89486q7L19xV13hG6d6zl/Y+Jd7pql1kbE5YlfTzUMnSarUZ2ednQa5ecv5kiEf
 0HCupdVY0K6o+p42VLDuHiSgvWNlDKMFc+oL1qiKaFQAX2xnxBgr4CXxcugGNBZ1la
 J2Qku6R5Mv19Q==
Date: Mon, 5 Oct 2026 17:25:31 +0200
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <20261005152531.GD3436@quark>
References: <20261002114338.12073-1-nsvatoslav515@gmail.com>
 <20261002232934.GB15366@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261002232934.GB15366@quark>
X-Headers-End: 1xDkZR-0002Ux-Sf
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: convert pagecache_read() to use
 folios
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 02, 2026 at 04:29:34PM -0700, Eric Biggers via Linux-f2fs-devel wrote:
> On Fri, Oct 02, 2026 at 02:43:37PM +0300, Svyatoslav Nikolenko wrote:
> > Replace page-based APIs with folio equivalents in pagecache_read()
> > to migrate fs/f2fs/verity.c away from struct page.
> > 
> > Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> 
> This will conflict with
> https://lore.kernel.org/fsverity/20261002223705.2175542-5-aalbersh@kernel.org
> 
> I'm checking if that one will go into 7.4.  If so, this one won't be
> needed.

I applied
https://lore.kernel.org/fsverity/20261002223705.2175542-5-aalbersh@kernel.org
for 7.4, so there's no need for this one.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
