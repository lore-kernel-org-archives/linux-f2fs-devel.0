From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] f2fs: add unlikely() macro for compiler more
	aggressively
Date: Fri, 06 Dec 2013 10:24:31 -0800
Message-ID: <87siu5vnvk.fsf@tassilo.jf.intel.com>
References: <1386310509-5864-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <andi@firstfloor.org>) id 1Vp04u-0007qE-MT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 18:24:40 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vp04s-0007Lt-Uh for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 18:24:40 +0000
In-Reply-To: <1386310509-5864-1-git-send-email-jaegeuk.kim@samsung.com>
	(Jaegeuk Kim's message of "Fri, 06 Dec 2013 15:15:09 +0900")
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Jaegeuk Kim <jaegeuk.kim@samsung.com> writes:
>  	struct page *page;
>  repeat:
>  	page = grab_cache_page(mapping, index);
> -	if (!page) {
> +	if (unlikely(!page)) {

This is completely pointless, gcc already considers any test for NULL
unlikely.

In general i would advise against splattering unlikely all over your
code, the benefits are very minimal and programers often get it wrong.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
