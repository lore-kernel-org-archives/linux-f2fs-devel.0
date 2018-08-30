From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Out of inodes on my f2fs partition
Date: Thu, 30 Aug 2018 11:45:31 -0400
Message-ID: <CAF_dkJCgEfdSKM2ibkPezKW0dLN7QawwALX6p=-wYz64ZSe0sw@mail.gmail.com>
References: <CAF_dkJAhK_1WtPF_2s5xUX60k87iMLbAYHV1=0S2aKQv3jh8Ng@mail.gmail.com>
 <5adf6554-6881-1bd6-3be2-28ae6c72f794@kernel.org>
 <CAF_dkJC5GvRzweVkCKWeHMuRWp=6tNdDDR14VLrGY7NcZs7ObQ@mail.gmail.com>
 <e18462d8-10bb-3939-e3b3-cbd764654c31@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fvP93-0001uG-Nj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:46:05 +0000
Received: from mail-oi0-f46.google.com ([209.85.218.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fvP92-003sR2-C1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 15:46:05 +0000
Received: by mail-oi0-f46.google.com with SMTP id b15-v6so16210498oib.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Aug 2018 08:46:04 -0700 (PDT)
In-Reply-To: <e18462d8-10bb-3939-e3b3-cbd764654c31@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Aug 30, 2018 at 11:40 AM Chao Yu <chao@kernel.org> wrote:
> Hi Patrick,
> On 2018/8/30 23:30, Patrick Doyle wrote:
> > On Thu, Aug 30, 2018 at 11:22 AM Chao Yu <chao@kernel.org> wrote:
> >>
> >> Hi Patrick,
> >>
> >> Can you try -i option?
>
> Sorry, I mean mkfs.f2fs -i /dev/xxx;
-i isn't an allowable option to mkfs.f2fs:
Usage: mkfs.f2fs [options] device [sectors]
[options]:
  -a heap-based allocation [default:1]
  -d debug level [default:0]
  -e [extension list] e.g. "mp3,gif,mov"
  -l label
  -o overprovision ratio [default:5]
  -O set feature
  -q quiet mode
  -s # of segments per section [default:1]
  -z # of sections per zone [default:1]
  -t 0: nodiscard, 1: discard [default:1]

>
> And you can use stat -f /your_mount_option to see whether largest number of
> inode support in new image increased.
"stat -f" shows the same information as "df -i".  Both show that I
have 9784317 total inodes, and that isn't enough for the builds I am
performing on this partition.  (The free number has gone up a bit as I
have deleted results from a previous build).

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
