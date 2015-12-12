From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: status of 3.18 branch?
Date: Sun, 13 Dec 2015 00:13:31 +0100
Message-ID: <20151212231331.GA2587@schmorp.de>
References: <20151212212721.GB3480@schmorp.de>
	<CAOtxgycxVkuLFOBiB0FGfJ3UrE-5TZCDK8dVu8XeNZrb2hb28w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1a7tMF-0008Tn-Vm
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 23:13:43 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a7tMC-0008ST-SU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 23:13:43 +0000
Content-Disposition: inline
In-Reply-To: <CAOtxgycxVkuLFOBiB0FGfJ3UrE-5TZCDK8dVu8XeNZrb2hb28w@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@gmail.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On Sat, Dec 12, 2015 at 01:42:18PM -0800, Jaegeuk Kim <jaegeuk.kim@gmail.com> wrote:
> Recently I decided to provide stable branches on top of each stable kernels
> to keep commit history.
> Could you check f2fs-stable.git instead of f2fs.git?
> 
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-stable.git/

Thanks for the info, after some guessing and trying, I used this in my SMR
article:

   git clone -b linux-3.18.y --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
