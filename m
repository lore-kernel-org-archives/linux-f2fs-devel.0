From: Chen Rong <rongx.a.chen@intel.com>
Subject: xfstests: generic/342 run failed in f2fs
Date: Mon, 25 Dec 2017 13:28:16 +0800
Message-ID: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <fstests-owner@vger.kernel.org>
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: philip.li@intel.com, rongx.a.chen@intel.comrongx.a.chen@intel.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi, everyone:

the issue as below:

# ./check generic/342
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 node01 4.15.0-rc4
MKFS_OPTIONS  -- /dev/sde1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sde1 /tmp/test1

generic/342      - output mismatch (see 
/home/ubuntu/git/xfstests-dev/results//generic/342.out.bad)
     --- tests/generic/342.out   2017-12-13 13:47:20.144000000 -0500
     +++ /home/ubuntu/git/xfstests-dev/results//generic/342.out.bad 
2017-12-25 11:13:12.928000000 -0500
     @@ -8,8 +8,7 @@
      48c940ba3b8671d3d6ea74e4ccad8ca3  SCRATCH_MNT/a/bar
      Directory a/ contents after log replay:
      SCRATCH_MNT/a:
     -bar
      foo
      File digests after log replay:
      9e5d56a1f9b2c93589f9d55480f971a1  SCRATCH_MNT/a/foo
     ...
     (Run 'diff -u tests/generic/342.out 
/home/ubuntu/git/xfstests-dev/results//generic/342.out.bad'  to see the 
entire diff)
Ran: generic/342
Failures: generic/342
Failed 1 of 1 tests

Is it a problem with my computer or a already known issue with f2fs?

thanks!
