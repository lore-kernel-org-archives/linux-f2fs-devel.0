From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: mmotm 2018-01-31-16-51 uploaded (f2fs)
Date: Wed, 31 Jan 2018 18:51:35 -0800
Message-ID: <b764819a-a7d6-6976-bc46-eab972566309@infradead.org>
References: <5a7264b1.mqPv/eshq6wqQFu6%akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <rdunlap@infradead.org>) id 1eh4yf-0006cP-H8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Feb 2018 02:51:53 +0000
Received: from bombadil.infradead.org ([65.50.211.133])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eh4yb-0003xV-1o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Feb 2018 02:51:53 +0000
In-Reply-To: <5a7264b1.mqPv/eshq6wqQFu6%akpm@linux-foundation.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-next@vger.kernel.org, sfr@canb.auug.org.au, mhocko@suse.cz, broonie@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 01/31/2018 04:52 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-01-31-16-51 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

It looks like this build error is not from an mmotm patch but from mainline
or linux-next:

on i386:
../fs/f2fs/super.c: In function 'f2fs_fill_super':
../fs/f2fs/super.c:2563:18: error: 'SB_I_CGROUPWB' undeclared (first use in this function)
  sb->s_iflags |= SB_I_CGROUPWB;
                  ^

Anyway, it's an unknown value.

-- 
~Randy

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
