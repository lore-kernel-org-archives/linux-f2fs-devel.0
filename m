From: Martin Blumenstingl via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/1] f2fs: fix validation of the block count
 in sanity_check_raw_super
Date: Sat, 22 Dec 2018 12:08:53 +0100
Message-ID: <CAFBinCA=-st_bM0Cz7mu-Hq6Asv5HAXPMwDZUjMj6GqMb8s=hw@mail.gmail.com>
References: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
 <201812221401.4m4zuU4G%fengguang.wu@intel.com>
Reply-To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <martin.blumenstingl@googlemail.com>)
 id 1gaf9c-0001rU-9H
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Dec 2018 11:09:12 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gaf9a-00CnNw-7w
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Dec 2018 11:09:12 +0000
Received: by mail-oi1-f196.google.com with SMTP id u18so6852294oie.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 22 Dec 2018 03:09:10 -0800 (PST)
In-Reply-To: <201812221401.4m4zuU4G%fengguang.wu@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: kbuild test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, kbuild-all@01.org, jaegeuk@kernel.org

On Sat, Dec 22, 2018 at 8:00 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Martin,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on f2fs/dev-test]
> [also build test WARNING on v4.20-rc7 next-20181221]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Martin-Blumenstingl/f2fs-fix-sanity_check_raw_super-on-big-endian-machines/20181222-142616
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> config: i386-randconfig-x006-201850 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>    fs/f2fs/super.c: In function 'sanity_check_raw_super':
> >> fs/f2fs/super.c:2498:46: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long long unsigned int' [-Wformat=]
>        "Wrong segment_count / block_count (%u > %u)",
>                                                 ~^
>                                                 %llu
I sent a v2 with this fixed and Chao Yu's reviewed by included
