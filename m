Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D7606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Em0h4oiw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z17QodhY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NgxMbP+g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=sYJFbK9hySeBSvPY4J03XN6UaLt6rOzpUqjHHqQLJ9s=; b=Em0h4oiw4VYgBLlIx1NBeHyVWG
	K+RFOB6d6rnDJvzfO/DRlNTkJVAO28Ha4icSwrXX9yRnSwYmMrbA8vqbbyTHGeRgcGsiLJqVxZAHd
	DGVsZHrWVoqrG6nhVo0VBa0Q7JDXDQsFAk1BxlFs7t270oT7o1x/w+1Zm6dbel1byofQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPHAq-000000004La-03VN;
	Fri, 06 Nov 2026 10:27:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hch@lst.de>) id 1xPHAp-000000004KF-0n64
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 10:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ng4EmQmVugyqJk+SkgZfhDd1lWc8URaGhyumeNdQoGs=; b=Z17QodhYu3QEwok3zHuHC6+pKi
 GdivJ24ORjlgOe/fYEWpf4JWXX8AUOCsxYRSG/AtcZAo+oufUHKB6M1FWpyx6D0PwDvJDvXTQemQL
 KNjRUTg8H7GE9vxPSMhnJ6kRTpu7JmgD1uaPNoBjL1sg1V7M54wOYuG3t5owH7jvo2rM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ng4EmQmVugyqJk+SkgZfhDd1lWc8URaGhyumeNdQoGs=; b=NgxMbP+gFDXcYha/Cqbziqfalp
 QadOMoKV3dFlz7egqdGV+2VFHotJcZT1Ry1J4qmXJCTjNmVUKgHa2Aj9dJfxtPzJMSY+yKApzcWDx
 Y6Ytwpvq8Ih10C9VdHZSANGNngPrko0q8Tg4+Z6h0yFaID58R4VXWxaiH/c82B00fBp4=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPHAc-000000007bh-10uD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 10:27:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3CFD468BEB; Fri,  6 Nov 2026 11:27:34 +0100 (CET)
Date: Fri, 6 Nov 2026 11:27:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261106102734.GE5319@lst.de>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-6-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-6-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xPHAc-000000007bh-10uD
Subject: Re: [f2fs-dev] [PATCH v2 5/5] f2fs: use I_VERITY_BUILDING instead
 of private flags
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, brauner@kernel.org,
 tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This looks good to me, but given the conflict with the f2fs tree maybe
delay this until after the current merge window?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
