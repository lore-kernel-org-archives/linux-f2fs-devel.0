Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AADC5B56A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUxkVMB/NyrcHxTppJ24CQtL7cEdgJx4tiz9QZfT0I0=; b=i7dXHmwSUuYoXEVUsXEE+h6JiI
	h+RD8MizFjAvclUpOmIzs78g17s7VNvi1WswFD3lSz03sIEABb5NjBvv3JZEpMtFm8KQd+Z7Omqqk
	3c0kOBSWD6TFrkiW+YErhXOpFuQpFXz7k0X43tas5Y8zUBTt+aRpriD+9I1t8dXRyocE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtpLn-00064G-K6;
	Tue, 11 Aug 2026 16:29:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wtpLm-000646-9g
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 16:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=91UQoUF/zJ0f/Ujq+Dd1GUnY1kZrsRbXE5pzSQBIH/s=; b=WGnYMA4GEY8ZCxA63MJKO6dRQD
 S4tOLH4nl6zTsucglwbOW0iGb9nfOU2W3xd0Lojmb9/tlAgoT7DuddnrZJ/8GA4gcQDN6r+UjuKO9
 QN8ltqYPFUaxNQXmB3QGvHqWEcblN3yrLp3LTIeWiMQqSTUEI2YOS7FrptkYdszW0o0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=91UQoUF/zJ0f/Ujq+Dd1GUnY1kZrsRbXE5pzSQBIH/s=; b=JAtKzAGE6ERg1sYIzNIs/Zf1fQ
 LarShVvVaCYS1r0rNMct5++nUR/CEOMa7zU2Tz67LLKlEPRSVooQ/z7Dh83aA1Ba7bykBEv0eFhgY
 RcvaBO0BMVlhqJfGOCoYQSDfGy/t5CVwNKrp7aFJYgdVBBc5AjDUSC3V8gvngwVow5VI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtpLk-00005t-G9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 16:29:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 004EB40243;
 Tue, 11 Aug 2026 16:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C99E11F000E9;
 Tue, 11 Aug 2026 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786465746;
 bh=91UQoUF/zJ0f/Ujq+Dd1GUnY1kZrsRbXE5pzSQBIH/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iWXP9E1SeF4g2o15ZNrOMyxfJ9jT7WnhSBimlWhEU3cHPs2HdAhN9qC8saGgdrb9r
 IAIdhMbaRQBnVz8f3jb037oBNQcL2odbhgChRfNIgmfH0zCyQqZkNA9mpobxMMlYzl
 dAq1pTnIp3Sueixht9VXowiiNlrO0WEEUxQIWWmGZUYUCjVfeePiJNEhv8GnDfGgXe
 Y3HTzvJ4IyXMNXBV1x3rcTevMEuBMrwiT8sbKYd8187HtK1I+huuq6L9gCD1yP9YFo
 2aw9PZFmMmt38UbtUzTNZb689mmTijVDH9KM8qMslc0+BxrxZnqAyRiE9zRaNmUMHn
 OdMAZUf1qiUJQ==
Date: Tue, 11 Aug 2026 09:29:06 -0700
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20260811162906.GC3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-14-aalbersh@kernel.org>
 <20260804183632.GO3556460@frogsfrogsfrogs>
 <anmNNNNy4YsV_KLB@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <20260810183102.GY3556460@frogsfrogsfrogs>
 <anrZR9SarXJMBLgI@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anrZR9SarXJMBLgI@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Headers-End: 1wtpLk-00005t-G9
Subject: Re: [f2fs-dev] [PATCH v14 13/21] xfs: use read ioend for fsverity
 data verification
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 11, 2026 at 10:18:05AM +0200, Andrey Albershteyn wrote:
> > > > "If we have fsverity and block device integrity attached to this bio,
> > > > we need to run both validations from the separate fsverity workqueue
> > > > to avoid deadlocking due to fsverity issuing its own reads."
> > > > 
> > > > (Assuming I understand the fsverity && pi case correctly.)
> > > > 
> > > > One thing I'm not clear about -- why is it safe to do the fsverity
> > > > validation here if PI isn't enabled?  Can't that also issue IO to pull
> > > > in merkle tree blocks?
> > > 
> > > Without PI, fsverity metadata is read without XFS bio completion
> > > path, we don't get here for the descriptor/metadata reads
> > > (see xfs_get_iomap_read_ops()). So, we won't block the queue, as
> > > data ioends won't be mixed with metadata ioends.
> > > 
> > > With PI, all fsverity reads goes through this path. We could get a
> > > case that data ioend is waiting for metadata IO to be completed which
> > > in turn is pending for data ioend to be finished (due to batch
> > > processing of multiple BIOs in the bio_complete wq).
> > > 
> > > So, this will issue more IO, but this IO will not get onto this
> > > queue (it will go through iomap_bio_submit_read()).
> > 
> > Ah, ok.  Maybe add to that comment:
> > 
> > "If we have fsverity enabled but block device integrity is not enabled,
> > completion of the fsverity metadata reads does not require a workqueue
> > so there is no deadlock potential."
> > 
> > then?
> > 
> > (Just echoing you to make sure I understand completely.)
> > 
> 
> yes,
> 
> I've changed it to:
> 
> +       /*
> +        * If we have fsverity and block device integrity attached to this bio,
> +        * we need to run fsverity verification of data folios from a separate
> +        * fsverity workqueue. This is necessary to avoid deadlocking due to
> +        * fsverity issuing more reads of fsverity metadata which would be
> +        * processed by the same worker in the BIO completion workqueue.
> +        *
> +        * Without device integrity, fsverity metadata IO will not use ioends for

I would like to nitpick this to "Without block device integrity..." but
otherwise this comment looks good to me :)

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +        * completion.
> +        */
> 
> 
> -- 
> - Andrey
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
