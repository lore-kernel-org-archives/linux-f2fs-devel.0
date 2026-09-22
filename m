Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6779AC982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/NGA+mhKJs5P1vTPYQJjFJVZa2FCvQosxFleeCjpgI=; b=LIRMC+QAILn5hZSk8/KSF+Z6hs
	YkPqzziNA2fwVfzGLIqiaRU5T0MucrUnKLMHvpqwV0VGN6gm05BIqQqgiMvNNyfpjY1V0rz0FNTjK
	O2RcFs/+TtW09CHhkCCHvAMQo/14r1mgX1IMmlq8PHgN6olJdQWmzed/683QpAC0b6x8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8vvf-0003up-Lg;
	Tue, 22 Sep 2026 08:32:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1x8vvZ-0003ue-PY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=; b=Y/AIwhEeSgnd7vF7bYuoDQmXg9
 gYuhCOafE76jA1JCbAt8Xd09IqrnHrJyOdDB0GGIQsyIpzl0IHwhTM7qLTrJqWbAEclC/WzpOry9E
 aWP4h+grqSnbtdJGJPBXtnqGcTut1zLlL3RQu/0K55unMPAhFce5qZ5HgWEZTIhJqF5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=; b=Mta3umIz2MdWOy+Ssxw0YoruHf
 qj5S93QLDh77NapJMLhUHHFnjCMMnXAQIe1apD8tQp4TC4YPeNfG8dgrIcbH0itIJng/i22opo8z6
 NXPqnKDxR4XwkD9QPL92ulM7UOgAPTrMtfsPfeF7z/1wISpepu6ZA5O89NMlQoCIdvNE=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8vvZ-0005v6-CC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:32:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790065951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=;
 b=OaX3zQe1A/i6f2euJs4tg+AxapSpwR/3HNRrlUjSYIpC9Mpdqm+Kj2SRngRipSkoiPwBFa
 zKsoxQVrgM/M7HDYboV9viAOVrd+eXclj+dPXexYRpPt2rIFqfz5jy2ytcX+46/V8uP7+C
 M88uKc11snPa14dasNqQJu3m5Pg4bAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-i6LktyKxNIaUPSGjYPNX0A-1; Tue, 22 Sep 2026 04:32:29 -0400
X-MC-Unique: i6LktyKxNIaUPSGjYPNX0A-1
X-Mimecast-MFC-AGG-ID: i6LktyKxNIaUPSGjYPNX0A_1790065949
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso28731735e9.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 01:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790065948; x=1790670748;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=;
 b=qJmHo1ANf5jj9EYXFZ4+n45GzFrP1Y/oPDw85x2K6mx5wRVYw35s9fgzIoL01AHv81
 7OjOzBDPfRN7zyArkrw+jhuPS2OszP8yHWFzg2aS1ZEHkZeB2wVLobfvxDZmBDDG1T9z
 cbQoD1iYkc5qC20YdJ4xmlHJvLSccuDs//P841J+gtbC4s89bs3rPekToqXMDHifprKZ
 DmdJU9W3N/u2HuPfUxt35rKiKyk+yHigWyp2O2i43jV9K8FJ3KHm1D8DJpJFV8UWDiXD
 pD2psgH6jk4nbvKsfts2vx8G07czRtnTVAVUmD12Xi7s90GOgiukBSZptZ0Ba6N8hZkG
 N0sA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAn1AwJ8KLcUbNRVt8NrPZMC5+lZC4elAlhDlcCHPrRiZPKRH+BsNX2HgmXWDK9p7MoxgdNakrqXSKC4M4o9Eg@lists.sourceforge.net
X-Gm-Message-State: AFuF++l/7JVmUVhBa7WnmIf1Q96H9bhiXno95RrDczMshGNykZyswJs8
 PGYhvNmYyqo99bQG4XZaohIrwFYIwLdmKjj8vT0q9dVFnLRZ+/BXtK6pg2OPTTR+Gabvuzp3KdY
 KGrNPESpq0YmVhVK7fuo+hM9uRVqDo5WI2TYWikZru7lWSb6xz1Q2yea2xPzluIAQNjeh+W7SMV
 ksrQ==
X-Gm-Gg: AYBFou3laSX1COTsFzUoqRWLQLTViiauDI9jHHRz6bafbcVgiaM7LZwsi2Y+5FhWGn2
 NuWYr6AfHr09OBH6mU9NFxwJENN9+wz5bQ+TaRFjkHBbteBCN/sL8Z/DrZkRf1bgShMJuOGR/bu
 K0+RBY4NGts2RV75gdfZYggd56fg9+ujKxEgnFCGnK6awOk7hDSdZ0+9FTTfn+iE4lpBG3OPj2I
 zTMCfD1OBmVKoeTmg7j4R85UiB1LoXmScPnEHGfT+Qgr6lOrvUMR3pWMqlOzVXm05C8Ei24CHBf
 R4c2f2G4nItrwpTkInfknsVUu+rkJoiXMuYEioH2Tmso/tAKEYdCVaaeX0Y6sxtZFnvh/kTKuC3
 L6EfZ9hNpKB1PeIN779aoXlJKNTkx39/6GQ==
X-Received: by 2002:a05:600c:3f0b:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49fc5750c61mr161766945e9.21.1790065948508; 
 Tue, 22 Sep 2026 01:32:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0b:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49fc5750c61mr161766615e9.21.1790065948022; 
 Tue, 22 Sep 2026 01:32:28 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdabe8a2asm32746655e9.4.2026.09.22.01.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:32:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:32:24 +0200
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <arI8cvh8rgIwmv9V@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-14-aalbersh@kernel.org>
 <20260922043402.GM2705364@frogsfrogsfrogs>
 <arIsIhrWltHi9Aej@infradead.org>
MIME-Version: 1.0
In-Reply-To: <arIsIhrWltHi9Aej@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D05WfvUoLkSTDese8VS5cyTxAiGjeROvtbpT5UUepio_1790065949
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1x8vvZ-0005v6-CC
Subject: Re: [f2fs-dev] [PATCH v16 13/21] xfs: add XFS_BMAPI_UNWRITTEN to
 unmap unwritten extents in __xfs_bunmapi()
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-22 00:20:02, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 09:34:02PM -0700, Darrick J. Wong wrote:
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index cc48f6e20e80..7ba76017ae56 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -5280,6 +5280,10 @@ __xfs_bunmapi(
> > >  		if (del.br_startoff + del.br_blockcount > end + 1)
> > >  			del.br_blockcount = end + 1 - del.br_startoff;
> > >  
> > > +		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> > > +				del.br_state != XFS_EXT_UNWRITTEN)
> > 
> > Odd indentation?
> > 
> > 		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> > 		    del.br_state != XFS_EXT_UNWRITTEN)
> 
> Yeah.
> 
> > /me again wonders if bunmapi ought to have its own flags instaed of
> > reusing *some* of bmapi.  But I concede that ought to be a different
> > cleanup, because figuring out which flags are for bunmapi.  I think it's
> > REMAP, ATTR_FORK, NODISCARD, and UNWRITTEN?
> 
> I think that would create more confusion than it helps.  OTOH asserting
> the valid flag would be helful.
> 
> Sashiko complains about interactions with the weird rtextent bunmap
> behavior.  Should we disallow fsverity with a larger than fsb
> rtextensive to not bother with this?  Btw, did you test this series
> with RT classic and or zoned?

yeah, I will disallow it

I did many revisions back, but haven't tested recent versions, I
will test with rt for the next version

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
