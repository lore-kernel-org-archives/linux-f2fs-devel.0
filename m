Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89177C3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2024 02:47:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sYGQR-0001EI-LA;
	Mon, 29 Jul 2024 02:47:51 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1sYGQP-0001E1-Rr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 02:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fZHb/SHRE/3ifgSnWXUU6RdFOsOVMjHd4oou3IInJ8M=; b=Udfl4dJ9jLG1gNXBxs9dBLtz5R
 eOSYwZz/yfalG+cxlcHlt7lnop4NgTqkvccvphE46LP6CWP1WcS9mNwB363WpIA3l0F+SL3IQ8O9M
 O9AzEtlJv2CBYzGzrlFS4PbkcA5Nco4Erv8OnkNJASkOChBbOP9IahxxYKKdTckPvAo4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fZHb/SHRE/3ifgSnWXUU6RdFOsOVMjHd4oou3IInJ8M=; b=BF7JpCqQ2k/FTQFOBt/GvV0S1X
 k3RLBAQ4ZwtZbhWPVJUrSjE2dxda87FVntsuZ6KQmuCrt2stgCG4xp/p8bccEHuw1zCnq1Vym9Mml
 ckSsc369nCNpM0hCqyOctGq4rpH1+G57X5zLNyyba1AoPK6+AyYvboUdm9ZmICjBGhyw=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sYGQO-0004kC-FE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 02:47:49 +0000
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net
 [173.48.113.198]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46T2iCas021007
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jul 2024 22:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1722221058; bh=fZHb/SHRE/3ifgSnWXUU6RdFOsOVMjHd4oou3IInJ8M=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=df87FzB0ozVVH+CgTcwMEcs4I/QMupH1v5UaCu+eKWsYipPHqwNfq+xoU+AwbmFES
 XglYWyH2T0bqfGMKiqqb7f8BgPWc99J0X9tvy+FhESpTBF1L22xiC2FC1f446oODjt
 iBuqmBBV3DQqo6zCK0EzNk7/t2+XUDshY7jru35GK2K9PEOXLH3OMamaNseC0BCt/d
 /oC2H8CyBUQgK28PS9XyjbgX5JMrmtd4HLTu5K6dVVUmTuTMeWBJVJ3eXz5Hc47MNG
 WfInu203XLvfCVgBGrYGUutstQSXJjCLXUGwtKKoa113i/ylRKEI9glPd25dXhsd7G
 poAxlPts/cE+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id D00BE15C02D3; Sun, 28 Jul 2024 22:44:12 -0400 (EDT)
Date: Sun, 28 Jul 2024 22:44:12 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Youling Tang <youling.tang@linux.dev>
Message-ID: <20240729024412.GD377174@mit.edu>
References: <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu> <ZqPmPufwqbGOTyGI@infradead.org>
 <20240727145232.GA377174@mit.edu>
 <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>
X-Headers-End: 1sYGQO-0004kC-FE
Subject: Re: [f2fs-dev] [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 Youling Tang <tangyouling@kylinos.cn>, linux-f2fs-devel@lists.sourceforge.net,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@infradead.org>,
 Chris Mason <clm@fb.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 29, 2024 at 09:46:17AM +0800, Youling Tang wrote:
> 1. Previous version implementation: array mode (see link 1) :
> =A0=A0 Advantages:
> =A0=A0 - Few changes, simple principle, easy to understand code.
> =A0=A0 Disadvantages:
> =A0=A0 - Each modified module needs to maintain an array, more code.
> =

> 2. Current implementation: explicit call subinit in initcall (see link 2)=
 :
> =A0=A0 Advantages:
> =A0=A0 - Direct use of helpes macros, the subinit call sequence is
> =A0=A0=A0=A0 intuitive, and the implementation is relatively simple.
> =A0=A0 Disadvantages:
> =A0=A0 - helper macros need to be implemented compared to array mode.
> =

> 3. Only one module_subinit per file (not implemented, see link 3) :
> =A0=A0 Advantage:
> =A0=A0 - No need to display to call subinit.
> =A0=A0 Disadvantages:
> =A0=A0 - Magic order based on Makefile makes code more fragile,
> =A0=A0 - Make sure that each file has only one module_subinit,
> =A0=A0 - It is not intuitive to know which subinits the module needs
> =A0=A0=A0=A0 and in what order (grep and Makefile are required),
> =A0=A0 - With multiple subinits per module, it would be difficult to
> =A0=A0=A0=A0 define module_{subinit, subexit} by MODULE, and difficult to
> =A0=A0=A0=A0 rollback when initialization fails (I haven't found a good w=
ay
> =A0=A0=A0=A0 to do this yet).
> =

>
> Personally, I prefer the implementation of method two.

But there's also method zero --- keep things the way they are, and
don't try to add a new astraction.

Advantage:

 -- Code has worked for decades, so it is very well tested
 -- Very easy to understand and maintain

Disadvantage

 --- A few extra lines of C code.

which we need to weigh against the other choices.

      	      	       	       	   - Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
