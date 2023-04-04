Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE0EC761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 23:22:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjpys-0005SI-7f;
	Tue, 04 Apr 2023 23:22:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1pjpyr-0005SB-II
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 23:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zSHNUytnzarXrq33PPPPjHo0/yqLuRSsqrnGb1/RG7w=; b=mvvvcu0T6YBIGOdQoWJGOLvcFo
 zXVRRG1SUec0YK4knTJZgKeXU07AjlVXpuiXgcTly8xYIEzujLKFeUspLKFSR6+FeSSsIJ6MSSzsq
 YgXuXK6NAdCQLY0cIhSJAA7ugNWWnoXyzhx+HiRwCKeIuiRdK8G3NdhYt6aSNqLQTopU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zSHNUytnzarXrq33PPPPjHo0/yqLuRSsqrnGb1/RG7w=; b=gzrc6Na3bmyzw+mNussjK2PGq+
 EtcZooy0mz22SW0syg7aaEiqrj9giX9ER97BaKO1RxiL3mqU7GSfmAAJDF5MDKEPq60rlpGuINUDz
 hDP83a/Op/+iFGoF8UjJT1awcC1MCybl+L1PWbsZ/x9fg/LMpwKqBD0+1qmOQ/87vf9s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjpyn-0001jj-Su for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 23:22:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 800C4639A9;
 Tue,  4 Apr 2023 23:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD23C433D2;
 Tue,  4 Apr 2023 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680650535;
 bh=wmW6nn1dW0G7ZUK1nyoM03KcQYEFzLGdk68Km/BFqaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZZj10jKRNecy8t8ufVTHZDF49qF6T32i58y3DEOIeipYODmpuNnsQ8Hzia4pi4LqH
 EE4sPsq93OOt1W3Hp5LhcSaKzWV3TVOzbejyLrSA2rc131GqbSgWb7jdyV1bgwsdW8
 2LMFo2UqiNnl8qsLV5eghGCe62GCRgrz1woC6uvYdx7dcNNrNOdbQNmEvqJj5688gZ
 hbnUNWYxq0r0Ci/4A8EPpqh4TgYzHIAq6HkkgeGEC9G82mP+E8k4y/36+dPM3sHY0g
 Qn5FjtYqObCRpIZuZQSEWIo1a4yk8azE0bLTEpuOKnXKGcjmuNM+Vfvvhw+axyzOPN
 8DRyUk06RKN2A==
Date: Tue, 4 Apr 2023 16:22:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20230404232215.GC109960@frogsfrogsfrogs>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
 <20230404221653.GC1893@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404221653.GC1893@sol.localdomain>
X-Headers-End: 1pjpyn-0001jj-Su
Subject: Re: [f2fs-dev] [PATCH 3/5] fstests/MAINTAINERS: add supported
 mailing list
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
Cc: linux-cifs@vger.kernel.org, brauner@kernel.org, linux-ext4@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>, linux-btrfs@vger.kernel.org, amir73il@gmail.com,
 linux-nfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, anand.jain@oracle.com, jack@suse.com,
 fdmanana@suse.com, ceph-devel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 04, 2023 at 03:16:53PM -0700, Eric Biggers wrote:
> Hi Zorro,
> 
> On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> > +FSVERITY
> > +L:	fsverity@lists.linux.dev
> > +S:	Supported
> > +F:	common/verity
> > +
> > +FSCRYPT
> > +L:      linux-fscrypt@vger.kernel.org
> > +S:	Supported
> > +F:	common/encrypt
> 
> Most of the encrypt and verity tests are in tests/generic/ and are in the
> 'encrypt' or 'verity' test groups.
> 
> These file patterns only pick up the common files, not the actual tests.
> 
> Have you considered adding a way to specify maintainers for a test group?
> Something like:
> 
>     G:      encrypt
> 
> and
> 
>     G:      verity

Yes, good suggestion.

--D

> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
