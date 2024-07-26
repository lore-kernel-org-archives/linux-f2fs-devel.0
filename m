Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBB1C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:12:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sXPQx-0000YD-Dj;
	Fri, 26 Jul 2024 18:12:51 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tytso@mit.edu>) id 1sXPQw-0000Xz-7W
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 18:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Fhxb1rvuFCxd4qmqtkOdrIw4+4M+R26H+9OpLL4wi4=; b=Z/LXQ7pNOGURN8YBXikeB9BMG9
 VDD8Wj+gTMVQAwMRvk4rRKhmboU0v2sUjP6QY3EbIfaRbk7R/5F0es0Jgu937uAuG3e8mp4UfWRv3
 8HQig0SlyIPrGSIM2mCO8D8imW8TCj2bHQk9v0uFw3dnB1YMoLb/fQfQxsh5afRhn5sg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Fhxb1rvuFCxd4qmqtkOdrIw4+4M+R26H+9OpLL4wi4=; b=aekis2rK5s3bEeH175LEh6z9nz
 hNpbYXssL1UqpCFo536xA0xZB6YKhmG/nK77U6Z3sqBvG/krwTglpa4GhJgNxZKORjGcn8hKxIW2u
 +d+mMBnucwj6PHMCuoO71A0W1nGtx7BoKaIpktgA0y/zv75RalYqpRyVhT+dr1R7IpIc=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sXPQu-0006Ra-BA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 18:12:50 +0000
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net
 [173.48.113.198]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46QHw1LW007490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jul 2024 13:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1722016688; bh=6Fhxb1rvuFCxd4qmqtkOdrIw4+4M+R26H+9OpLL4wi4=;
 h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
 b=Q70gHPYBpCfYxY5Qatx+1LA6hRcuUmkzc+QIW0riQPdRIugCZOzuxFMXy+ZtTn0cv
 +LnXfjs4CB43/RFXfi6DPIGzZLfj67+qW7v+cMmwcfGWC0ExWgRnKm3rfO2k6/711I
 PYVU6P56QKUdMG/Tmmlirjz9gB9C6m3US/l3FNbLLfLltgQsKGiE+y9gqXQv9tI4ux
 XNT/JQL5eFxb21yXBpMIR9/+HRensgW+wD5pzO+fygl2JuKYDg3SKo35copm1CRtw0
 xhjpMtQJS1XOl+IH+xg6xPJPjWQYPSft68O4xRNiQR9ZPvc7HID84liiTTrDD8UVAm
 cHtvEViGLl/Kw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 04CC115C0251; Fri, 26 Jul 2024 13:58:01 -0400 (EDT)
Date: Fri, 26 Jul 2024 13:58:00 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Sterba <dsterba@suse.cz>
Message-ID: <20240726175800.GC131596@mit.edu>
References: <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726152237.GH17473@twin.jikos.cz>
X-Headers-End: 1sXPQu-0006Ra-BA
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
 Arnd Bergmann <arnd@arndb.de>, kreijack@inwind.it,
 Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-btrfs@vger.kernel.org,
 Youling Tang <youling.tang@linux.dev>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 26, 2024 at 05:22:37PM +0200, David Sterba wrote:
> All of this sounds overengineered for something that is a simple array
> and two helpers. The code is not finalized so I'll wait for the next
> version but specific file order in makefile and linker tricks seems
> fragile and I'm not sure I want this for btrfs.

Yeah, that's my reaction as well.  This only saves 50 lines of code in
ext4, and that includes unrelated changes such as getting rid of "int
i" and putting the declaration into the for loop --- "for (int i =
...").  Sure, that saves two lines of code, but yay?

If the ordering how the functions gets called is based on the magic
ordering in the Makefile, I'm not sure this actually makes the code
clearer, more robust, and easier to maintain for the long term.

	      	      	  	    	     	 - Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
