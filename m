Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C087D715E8
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=69hkcVTOSSb6is61HfuvHeEsICev0/gSbpsXUvHL7i4=; b=VuSe7set+hUxgfNWxvdYSApJ5j
	fnDmIHxoszYRhl8uOtYSXFbS80F7+nk7q0EEeRpiZQN7IJ2HonGJzXwu1mX1aPLI+WoPphvUAF/Of
	+MrY4WojopMnXGqS3Xbg7xRIUIym8pneN8P5n23nE1alYA3gDFwJ6gmn8zFieQ/J3wjI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjd86-00058y-UC;
	Sat, 24 Jan 2026 12:52:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1vjd84-00058e-T0
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 24 Jan 2026 12:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7G0EqSPcYrX2qweIAuB6PdaWKot5qtSSe5mp6N66xU=; b=XRjLHUbeR+kB3o+vq9La8FPpWm
 FiWARJmWMdh+VvHkuxPwwVTjN+GIRXDygwoL5aLGHMoqhiDSMb2ZRc/NnvwLW/3UKnQowuhJQdUfn
 wzz0R0Qwaar/0aiXj8iXTZW1yDdi37eKyHV2zQIBE24sa4irzy4QtIxPZcC+fGMELcA0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o7G0EqSPcYrX2qweIAuB6PdaWKot5qtSSe5mp6N66xU=; b=fy0x3HjQnX4h07KicbCVlE+xEk
 iKjOBv/MHhu26umRWSVfbb9sAMPiE3jTLKZ7oFq8ulRZU0h1syHEVCZsuOp+7u3uKdwW4NoP/UuWv
 FB1aHa1cl1BftDG1IQZp0aEgFG71QTyT2GVe3qf0B5qZDidyUlKOWXEKP9iDHW6hKjRg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjd85-0002Hg-9c for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 24 Jan 2026 12:52:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EF9460053;
 Sat, 24 Jan 2026 12:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ABCC116D0;
 Sat, 24 Jan 2026 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769259150;
 bh=tF55d1hz2qgaV0ckyIKSTzXVHak1AXu30pHTv/T/mwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l+lF+5cwXE+InK8NAW7SdkJD0wOGPO5SHbCCzqKnVJfHTw275VH76hYus//Td+Gqs
 Zd+ZunPF3ILfSZEZzPBQpRyDiragiKRjGpqqXrVfONayxSjMvuvNmBwXKNLh/vvLAm
 XwUAFehKHHlLHHvzMfAfFR130CJe2Bs01+Vk5H5bsLGJC5WZh0mD0cIT1FfV+0m+yU
 xl/RAjmX7pv+oCD3w2KN/Jut3RWFMHoS2K8EKWWjti2e5+RI9BTpcSdXgrTszzeL3S
 EzZ9U0OxQ1KqFq4Z/qxBkgQWUSI9JWeUEuZPVdOoQqWWjA5+XbTPA+eiY7lIvCQzH6
 oDJu3FYpngXdA==
Date: Sat, 24 Jan 2026 13:52:21 +0100
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
 <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com>
X-Headers-End: 1vjd85-0002Hg-9c
Subject: Re: [f2fs-dev] [PATCH v6 00/16] Exposing case folding behavior
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@manguebit.org>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Shyam Prasad N <sprasad@microsoft.com>,
 frank.li@vivo.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, glaubitz@physik.fu-berlin.de,
 Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-nfs@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 Hans de Goede <hansg@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 23, 2026 at 10:39:55AM -0500, Chuck Lever wrote:
> 
> 
> On Fri, Jan 23, 2026, at 7:12 AM, Christian Brauner wrote:
> >> Series based on v6.19-rc5.
> >
> > We're starting to cut it close even with the announced -rc8.
> > So my current preference would be to wait for the 7.1 merge window.
> 
> Hi Christian -
> 
> Do you have a preference about continuing to post this series
> during the merge window? I ask because netdev generally likes
> a quiet period during the merge window.

It's usually most helpful if people resend after -rc1 is out because
then I can just pull it without having to worry about merge conflicts.
But fwiw, I have you series in vfs-7.1.casefolding already. Let me push
it out so you can see it.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
