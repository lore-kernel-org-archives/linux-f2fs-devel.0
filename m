Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E86CC77B7E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jun 2023 14:52:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q4jfT-00079b-Kh;
	Thu, 01 Jun 2023 14:52:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1q4jfQ-00079V-Bq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 14:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ocmgG3AwXqD+xUhaoXDH/qEJqT72EouO1rvjHBr6Htk=; b=DzxbHgryKYABnylCmLFvmSzOvy
 J+pVtELkq5Q9KxqGU4CGxPtwIaVh2IREY7dwWP+jFppQBet9q1N3ZJBTDYd9U8r4BbxADWeHAeSnC
 WJ/uoVAZJV9eSv4qq7Dkg3L4sFwY7I0uaWsQQHEs1/lwDj1mPt0ZT/VTjCxOmRAS6Q9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ocmgG3AwXqD+xUhaoXDH/qEJqT72EouO1rvjHBr6Htk=; b=FveTt2CWjA/OZvr04xvHymrOWG
 iftKfA3UGK17zCszTjghGML0KprzdPpiHlRCBrxUR49tXaP8iB8dQB2GqrpK3rWc5VIZznUghSFjw
 oHDmLO3LFJ9vfLJr8R3LgvZJ1ShV/vUz1ctvm4cux6jt7aVsFEfJD05avrTsSqavRPkY=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q4jfM-008SEv-7s for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Jun 2023 14:52:44 +0000
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net
 [173.48.119.27]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 351EqMka013065
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 10:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1685631145; bh=ocmgG3AwXqD+xUhaoXDH/qEJqT72EouO1rvjHBr6Htk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VM8/Uu97seftS0qeq+6Ysp9BXkNhjUcaVl9U89FzKjVHN95D2/9uD9/Z0stw6GayT
 TLelYRPi4d2jWT53MdX2oZUfk1PoQcJx+Iz594HiUAahSJ9pKzl9apyvKB/+MjiztU
 bM2Ot+kBWhdNFklD0RSdcbI299bbFE+U8JB76uo6iEoCt4Ql/BS6rmFognIzCNnLq+
 qexrwfUTKnCX32iQ9Da7QywUgvoU0558ckrfhgFf92/Sv7BzpVcMYqbv+yOze6k/Fl
 6vE0tJLu/1VlEkWol5ckl73dRDgvmHCHXBgfYZlYhDQP/K7RMQlgIh7fIpwMQeSXj8
 Is7CFhO77tRDA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 4753A15C02EE; Thu,  1 Jun 2023 10:52:22 -0400 (EDT)
Date: Thu, 1 Jun 2023 10:52:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Message-ID: <20230601145222.GB1069561@mit.edu>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-1-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601105830.13168-1-jack@suse.cz>
X-Headers-End: 1q4jfM-008SEv-7s
Subject: Re: [f2fs-dev] [PATCH v2 1/6] ext4: Remove ext4 locking of moved
 directory
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
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 01, 2023 at 12:58:21PM +0200, Jan Kara wrote:
> Remove locking of moved directory in ext4_rename2(). We will take care
> of it in VFS instead. This effectively reverts commit 0813299c586b
> ("ext4: Fix possible corruption when moving a directory") and followup
> fixes.

Remind me --- commit 0813299c586b is not actually causing any
problems; it's just not fully effective at solving the problem.  Is
that correct?

In other words, is there a rush in trying to get this revert to Linus
during this cycle as a regression fix?

I think the answer is no, and we can just let this full patch series
go in via the vfs branch during the next merge window, but I just
wanted to make sure.

Thanks!

					- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
