Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5200606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a4Bk6Kt+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RXdYzUpS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a1qrFSED;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3SBUo3Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=urMpHQZLBySRrY/uIMmdtIuHU1xT3NUlaNOihrZSavc=; b=a4Bk6Kt+Iu3VZ1y72Pr6NqJrxp
	4R2Ob2I6cQw/pFa8m7jVjmsC+/GaHknthHq99kxDs45xNpXqIBbYqbvdkNfazrlM8iiA4qVaO5TPT
	QxkVehgr3IQca3tsbbXe0LY9QJj4rp9+vpABSkPz7nW5rSpJ2jKTwxVcPN1K4I/bzIqU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUJn3-000000006Yj-1JMR;
	Fri, 20 Nov 2026 08:16:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUJn1-000000006Y6-3StX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gRnXn7A8a8ltwBq+RheRl5mDgBsU2Z5PbLlb1u7e8CU=; b=RXdYzUpS2Md8P+WnMInrstVJfz
 peL8U1BcLMU7Pqhbvqtc72MlXu29tkynW6Va572BLi+8iX0M3O/cYmJsF04YPNbUbsfmu6HbO0vHI
 wTOqbh99pFoZAT2zteEFO3PjqJV0bRXMGXjm6fTF/qKftpYDaOJmbFh7m7ACFeghD7YM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gRnXn7A8a8ltwBq+RheRl5mDgBsU2Z5PbLlb1u7e8CU=; b=a1qrFSEDfoSGoChwYLTeLUd7kI
 jDJs33jpRdx5Ih5scs6iFIKNgEegGrEKGdtgmPBDAwKKpIhHT5ktdMsti/ywrjPQG7razEGt96GlV
 facuP4x8UQqrEcBO8i+aWi0klfVtkWbWGUljDNOC5/w75FoNwaieW5EVaeHTZZmi5DRI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUJn0-0000000072v-22eB
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:16:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BD6E411AC;
 Fri, 20 Nov 2026 08:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE661F000CA;
 Fri, 20 Nov 2026 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795162565;
 bh=gRnXn7A8a8ltwBq+RheRl5mDgBsU2Z5PbLlb1u7e8CU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O3SBUo3Qd1oYvzOGUJ5rYpD2S8YhyUOUglVc/LxFyzDJLfoAn4a0DXLMJ/nR+m9M8
 sNN5u2N3okNnUETsRESBjksvHqkmuUTTC0GL7Ont3UhHFelFdFj0HhHZ7depwkLkrM
 Tfv/2kQ7CM3b6uy97snz53Hu1sfbx+dQsM6VxJ2fSK5sIWd8oDLSs7VmdAamuShnoF
 Q9DEGgGxDOMCy7wPXUwg36k8y4264dUYGGGdHlM6kDleWtbjv+uydRghVSrMVw5/EQ
 7uL+EVf4BdNUN8gnHe6Dn2+hYNRRLpE+tOjk9vaTUe7t98luO9gcouKOjdlybNTogO
 pIEzydj/7wkog==
Date: Fri, 20 Nov 2026 09:15:58 +0100
To: Christian Brauner <brauner@kernel.org>
Message-ID: <awABahzFVV5pX6bG@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
 <20261119-gefunden-beteiligen-epidemie-5a23ff160ef4@brauner>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261119-gefunden-beteiligen-epidemie-5a23ff160ef4@brauner>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUJn0-0000000072v-22eB
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-19 21:48:27, Christian Brauner wrote:
> On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> > Every filesystem that supports fs-verity keeps a private runtime inode
> > flag meaning Merkle tree is currently being built *_VERITY_IN_PROGRESS.
> > They all serve the same two purposes: reject a concurrent enable with
> > -EBUSY and let the write paths recognize the special writes done while
> >
> > ...
> >
> > +/**
> > + * fsverity_is_building() - is fs-verity being enabled on the inode
> > + * @inode: inode to check
> > + *
> > + * This checks whether the inode's Merkle tree is currently being built.
> > + * While this is the case the file is read-only to userspace and the only writes
> > + * allowed are for the fs-verity metadata. This becomes false when fsverity
> > + * metadata is fully created and written to disk or building failed.
> > + *
> > + * Return: true if fs-verity is being enabled on the inode
> > + */
> > +static inline bool fsverity_is_building(const struct inode *inode)
> > +{
> > +	return inode_state_read_once((struct inode *)inode) & I_VERITY_BUILDING;
> 
> Isn't the fix to make inode_state_read_once() take a const struct inode *?
> 

Yes I have a fix, I will send as part of this series in the next
revision

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
